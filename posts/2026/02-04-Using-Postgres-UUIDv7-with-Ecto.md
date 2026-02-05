%{
  title: "Using UUIDv7 with Ecto and PostgreSQL",
  author: "Matt",
  tags: ~w(postgres ecto elixir phoenix),
  description: "Postgres 18 adds built-in support for UUIDv7. Here's how to use it in an Ecto schema."
}
---

Postgres 18 adds support for generating UUIDv7s out of the box; no extensions required.
Unfortunately, it's less obvious how to use these for the `id` in our Ecto schemas.
But don't worry, it only requires a few small changes and no new dependencies.

## TL;DR

If you just want to see how to set it up, jump straight to the finished [working example](#working-example).

## What is a UUIDv7 (and Why You Might Care)

A UUIDv7 is a UUID (Universally Unique Identifier) where the first 48 bits represent a Unix timestamp[^1].

This gives you all the benefits of using a UUID, but with a few nice properties.
First, if you're using these as primary keys, it lets you sort by an `id` field and get rows in a chronological order, as if you were using an integer `id`.

[^1]: [UUID Version 7](https://www.ietf.org/archive/id/draft-peabody-dispatch-new-uuid-format-04.html#name-uuid-version-7)

Second, it gives you a way to take a UUID and extract a timestamp from it, allowing you to avoid an `inserted_at` column.

And one last reason is that it can make for better database indexes because they'll be generated in an already sorted order.

So how do we use this in an Ecto schema?

## Create a Schema with `binary_id`

First, we need to add a schema.

If we're writing this by hand, we would add the `@primary_key` and `@foreign_key` attributes to indicate our primary key is going to be a `binary_id`.

```elixir
defmodule MyApp.Post do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "posts" do
    field :title, :string
  end

  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
```

When using Postgres, a `binary_id` Ecto type will map to a UUID.

If we're generating this using `phx.gen.schema` tasks (or any variations, like `phx.gen.live`), we would include use the `--binary-id` flag.

```sh
mix phx.gen.schema MyApp.Post posts --binary-id title:string
```

## Add a Migration

Next, we'll need to add our database migration.
Let's start with an empty `change/0` function.

```elixir
defmodule MyApp.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do

  end
end
```

In this case, we're creating the table.
Normally, `create/2` when given a `table` will automatically include an `id` primary key field that is a `bigserial`.
However, we can pass `primary_key: false` to disable this, and use `add/3` to manually add an `id` column.
We'll add this `id` with `primary_key: true` so that this will be marked as a primary key.

```elixir
def change do
  create table(:posts, primary_key: false) do
    add :id, :binary_id, primary_key: true
    add :title, :string
  end
end
```

If you used `mix.gen.schema`, this is what your generated migration will look like.
If we wanted a plain old UUIDv4, we would be done here.

## Creating UUIDv7 In The DB

To get our database to generate a UUIDv7, there's one more thing we need to do.
We need to include a `default` in the options when adding our `id` field.
This default could be an normal Elixir value, but it can also be a `fragment` that wraps some SQL, which we can use to add Postgres function calls.

We'll set `default` to be a `fragment` that wraps a call to the built-in Postgres [`uuidv7`](https://www.postgresql.org/docs/18/functions-uuid.html) function, like so:

```diff
     create table(:posts, primary_key: false) do
-      add :id, :binary_id, primary_key: true
+      add :id, :binary_id, primary_key: true, default: fragment("uuidv7()")
       add :title, :string
     end
```

Now we can run our migration using `mix ecto.migrate`.

If we fire up `psql`, we can use `\d posts` to take a look at our table schema and see that our `id` has a type `uuid` and the default is `uuidv7()`.

```
my_app_dev=# \d posts
                              Table "public.posts"
   Column    |              Type              | Collation | Nullable | Default
-------------+--------------------------------+-----------+----------+----------
 id          | uuid                           |           | not null | uuidv7()
 title       | character varying(255)         |           |          |
```

So far so good.
Let's generate a few UUIDv7s to see what they look like.

```
my_app_dev=# select uuidv7() as id_1, uuidv7() as id_2;
                 id_1                 |                 id_2
--------------------------------------+--------------------------------------
 019c2bff-57bc-7e15-874a-95fd2916a233 | 019c2bff-57bc-7e7a-ab47-07587aa65bf9
(1 row)
```

Notice how both ids have the same first 12 characters.
Let's insert a few rows to test our default.

Let's test it out by adding a few rows.
```
my_app_dev=# INSERT INTO posts (title) VALUES
    ('I May Be Wrong, But I Doubt It'),
    ('You Can''t Teach Heart')
    RETURNING (id, title);
                                   row
-------------------------------------------------------------------------
 (019c2c02-d41b-71a8-937f-85cc754fd12b,"I May Be Wrong, But I Doubt It")
 (019c2c02-d41b-7299-bc4e-af8c1f2a81cf,"You Can't Teach Heart")
(2 rows)
```

Everything looks good here, but if we move to the Elixir side, we'll find that we're not quite done.

### Why Are We Still Getting UUIDv4?

Let's jump into `iex` using `iex -S mix` and see what happens when we insert a `Post` from our application.

```elixir
iex(1)> MyApp.Post.changeset(%MyApp.Post{}, %{ title: "Wilt Chamberlain's Most Impressive Stat" })
iex(2)> |> MyApp.Repo.insert!()
%MyApp.Post{
  __meta__: #Ecto.Schema.Metadata<:loaded, "posts">,
  id: "af0d742c-affc-4e66-be9b-7f74e1db2438",
  title: "Wilt Chamberlain's Most Impressive Stat"
}
```

Hmm, that first section of our `id` looks drastically different than what we were seeing in our DB.
Has *that* much time passed?
Nope, this is just a UUIDv4.

You can tell by looking at the first digit of the third chunk.
That `4` tells us that this is v4.
We can confirm by taking a look back in `psql`.

```
my_app_dev=# select id, uuid_extract_version(id) as version, title from posts;
                  id                  | version |             title
--------------------------------------+---------+--------------------------------------
 019c2c02-d41b-71a8-937f-85cc754fd12b |       7 | I May Be Wrong, But I Doubt It
 019c2c02-d41b-7299-bc4e-af8c1f2a81cf |       7 | You Can't Teach Heart
 af0d742c-affc-4e66-be9b-7f74e1db2438 |       4 | Wilt Chamberlain's Most Impressive Stat
(3 rows)
```

If we take a closer look, when calling `Repo.insert!/2`, some debug info is logged out for us, including the `INSERT` statement.
Notice that the statement is providing an `id`, which means our default function is never getting called.

```sql
INSERT INTO "posts" ("title","id") VALUES ($1,$2) ["Wilt Chamberlain's Most Impressive Stat", "af0d742c-affc-4e66-be9b-7f74e1db2438"]
```

Ecto is automatically generating a UUID for us, which is not what we want.

## Disabling Ecto UUID Generation

When using the Phoenix generators (or just leaving it to the default), the `autogenerate` value for our primary key will be `true`.

```elixir
# lib/my_app/post.ex
@primary_key {:id, :binary_id, autogenerate: true}
```

This will cause Ecto to use the `autogenerate/1` callback defined on the type.
For a `binary_id`, this is `Ecto.UUID.generate/0`.

Let's disable `autogenerate` to let our database handle it.

```diff
-  @primary_key {:id, :binary_id, autogenerate: true}
+  @primary_key {:id, :binary_id, autogenerate: false}
   @foreign_key_type :binary_id
   schema "posts" do
```

Let's try it out.
We can recompile our app without restarting `iex` by using `recompile`:

```elixir
iex(3)> recompile
Compiling 1 file (.ex)
Generated my_app app
:ok
```

Now let's insert another `Post`.

```elixir
iex(4)> MyApp.Post.changeset(%MyApp.Post{}, %{ title: "Now America Is Tanking, Trust The Process" })
iex(5)> |> MyApp.Repo.insert!()
```

If we look at the debug log, we can see the `INSERT` statement no longer includes an `id`:

```
INSERT INTO "posts" ("title") VALUES ($1) ["Now America Is Tanking, Trust The Process"]
```

But the `Post` struct returned doesn't seem to have an `id`.

```elixir
%MyApp.Post{
  __meta__: #Ecto.Schema.Metadata<:loaded, "posts">,
  id: nil,
  title: "Now America Is Tanking, Trust The Process"
}
```

Did we just manage to insert a row without a primary key?
Nope.
It turns out that these `ids` are not automatically read back from the database after insert.
However, we can opt into this by setting `read_after_writes: true`.

```diff
-  @primary_key {:id, :binary_id, autogenerate: false}
+  @primary_key {:id, :binary_id, autogenerate: false, read_after_writes: true}
   @foreign_key_type :binary_id
   schema "posts" do
```

Let's recompile and try it one more time.

```elixir
iex(4)> recompile
iex(5)> MyApp.Post.changeset(%MyApp.Post{}, %{ title: "Why Do We Even Have a Regular Season?" })
iex(6)> |> MyApp.Repo.insert!()
%MyApp.Post{
  __meta__: #Ecto.Schema.Metadata<:loaded, "posts">,
  id: "019c2c35-6def-7686-b15d-4503bcd4ca4d",
  title: "Why Do We Even Have a Regular Season?"
}
```

There we go, our `Post` has been created with a UUIDv7, and the resulting struct has our `id`.
Looking at our `INSERT` log, we now see `RETURNING "id"`, which Ecto will combine with the application side data to give us the `Post`, complete with `id`.

```
INSERT INTO "posts" ("title") VALUES ($1) RETURNING "id" ["Why Do We Even Have a Regular Season?"]
```

<a name="working-example"> </a>

## The Complete Schema and Migration

#### Schema
```elixir
# lib/my_app/post.ex
defmodule MyApp.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: false, read_after_writes: true}
  @foreign_key_type :binary_id
  schema "posts" do
    field :title, :string
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
```

#### Migration
```elixir
# priv/repo/migrations/20260205031939_create_posts.exs
defmodule MyApp.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :binary_id, primary_key: true, default: fragment("uuidv7()")
      add :title, :string
    end
  end
end
```

### Conclusion

There you have it.
You now know everything you need to use a UUIDv7 for your primary key in an Ecto schema backed by PostgreSQL.

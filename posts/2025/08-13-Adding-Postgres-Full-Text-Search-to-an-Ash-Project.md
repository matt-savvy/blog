%{
  title: "Adding Postgres Full Text Search to an Ash Project",
  author: "Matt",
  tags: ~w(postgres elixir phoenix ash),
  description: "How does it pan out when you need to reach outside of what Ash does for you?"
}
---

I recently added Postgres Full Text Search to an existing Ash project.
This was honestly the first time I've had to add some functionality that Ash didn't already handle, so I was interested to experience some of these escape hatches first-hand.

## What We Are Trying to Accomplish

The app we're working with is a simple task management app.
Each task has a `title` and a `body`, which are both plain text that we'd like to be able to do a search over and receive ranked results.

## Making Our Text Searchable

First, we need to take the plain text we want to search through and convert it to a `tsvector`.
A `tsvector` is basically a version of the text where each word has been broken down into roots.
For example:

```sql
db=# select to_tsvector('i am writing a blog post about adding search to an app');
 'ad':8 'app':12 'blog':5 'post':6 'search':9 'write':3
```

Notice how the word "writing" became simply "write".
This means that searching for "write" will find references to documents that match both "writing" and "write".

We could do this transformation at the time we're running the search, but that won't do for a few reasons.
First, most tasks aren't being changed, which would mean that we're re-doing this work every time we want to search.
Second, we want to be able to add an index on these `tsvector`s so our search will be more performant.

What we want to do is add a generated column and then an index on that column.

## The First Escape Hatch

This is the first place where we reached outside of Ash.
Since I knew exactly how I wanted to define the column and index, it was easy enough to just run `mix ecto.gen.migration` and write our migration in plain SQL using `execute`.

Here, we're adding a generated column `search_vectors` that runs both our `title` and `body` (if one exists) through `to_tsvector`.
We'll get to that `setweight` later on, but I'm sure you can figure out what that's for.

```elixir
defmodule TaskApp.Repo.Migrations.AddSearchVectors do
  use Ecto.Migration

  def up do
    execute("""
      alter table tasks add column search_vectors tsvector generated always as (
          setweight(to_tsvector('english', title), 'A')
          || ' ' ||
          coalesce(to_tsvector('english', body), '')
      ) stored;
    """)

    execute("""
      create index idx_tasks_search_vectors_gin on tasks using gin(search_vectors);
    """)
  end

  def down do
    ...
  end
end
```

Once we run this migration, each row in our `tasks` table will have a searchable representation of its text, and it will have an index so that we don't have to scan the whole table.

## Searching

Now, we can actually search over this using a `tsquery`.
This process is similar to creating a `tsvector`, where words get broken down to their roots and pointless words like "the" get dropped.

We'll be using `websearch_to_tsquery`, which also lets us use operators like wrapping text in quotes to look for an exact phrase, and using `-` to negate certain words.

```sql
db=# select websearch_to_tsquery('writing a post about "full text search" -elasticsearch');
                         websearch_to_tsquery
 'write' & 'post' & 'full' <-> 'text' <-> 'search' & !'elasticsearch'
```

You can see if a `tsquery` matches a `tsvector` with the `@@` operator.
```sql
db=# select to_tsvector('write up a blog post about full text search')
        @@
    websearch_to_tsquery('writing a post about "full text search" -elasticsearch');
 t
```

## Adding it to our Ash Resource

The most essential thing we want to do is be able to list only tasks that contain our search query in the title or body.
We'll update our `list` action, which already accepts a map of filters, and if the map includes a `search_query`, we'll add a `filter` step.

Ash doesn't have any built-in way to convert our search query into a `tsquery` or use the `@@` operator, but it does give us `fragment` as a way to drop down to the raw SQL we want.

```elixir
# lib/task_app/todo_tasks/todo_task.ex
query
|> Ash.Query.filter(
  expr(fragment("search_vectors @@ websearch_to_tsquery(?)", ^search_query))
)
...
|> Ash.read()
```

## Ranking Results

Now that we can list only the tasks that match our search, we want to actually order them in a reasonable way.

Postgres gives us a `ts_rank` function, which will take a `tsvector` and a `tsquery` and give you a score to tell you how strong the match was.

```sql
db=# select ts_rank(
        to_tsvector('write a blog post about full text search'),
        websearch_to_tsquery('write a post')
    );
  ts_rank
 0.09735848
```

Our generated column uses `setweight(to_tsvector('english', title), 'A')` to give extra weight for a hit in the `title` compared to the `body`.

So obviously we want to sort by this score, so how do we access this in our application?

## Adding `search_rank` to our Resource

First, we'll add a `calculation` for `search_rank`, which will use another `fragment` to describe how to calculate this.

```elixir
# lib/task_app/todo_tasks/todo_task.ex
  calculate :search_rank,
            :float,
            expr(
              fragment(
                "ts_rank(search_vectors, websearch_to_tsquery(?))",
                ^arg(:search_query)
              )
            ) do
    argument :search_query, :string
  end
```

What's nice is that we can actually have unit tests to confirm that our ranking works the way we expect.

```elixir
# multiple hits
%{search_rank: search_rank_0} =
  generate(
    task(
      title: "#{query} has the magic word #{query}",
      body: "yo dawg, i heard ... #{query} on #{query}!"
    )
  )
  |> Ash.load!(search_rank: [search_query: query])

# one hit in title only
%{search_rank: search_rank_1} =
  generate(task(title: "has the magic word #{query}", body: "nothing special"))
  |> Ash.load!(search_rank: [search_query: query])

# multiple hits puts it higher
assert search_rank_0 > search_rank_1
```

Next, in the `list` action, we'll `load` and `sort` by this calculation.
We don't need to do anything special here since as far as this code is concerned, this is a calculation like any other.

```elixir
# lib/task_app/todo_tasks/todo_task.ex
query
|> Ash.Query.filter(
  expr(fragment("search_vectors @@ websearch_to_tsquery(?)", ^search_query))
)
|> Ash.Query.load(search_rank: [search_query: search_query])
|> Ash.Query.sort(search_rank: {%{search_query: search_query}, :desc_nils_last})
...
|> Ash.read()
```

Now we can search and have our results returned in order based on how strong of a match they were.

## Tying it into the Live View

Our LiveView already grabs the other filters from the query params, and this will be no different.
We'll update our `handle_params` to create a `search_form` that's populated with our search query and add that to our `assigns`.

```elixir
# lib/task_app_web/live/todo_task_live/index.ex
@impl true
def handle_params(params, _url, socket) do
  tasks = list_tasks(params, socket.assigns.live_action)
  search_form = %{"search_query" => params["search_query"]} |> to_form()

  {:noreply,
   socket
   |> stream(:tasks, tasks, reset: true)
   |> assign(:search_form, search_form)
   ...
   }
end
```

Next, we'll add a simple input to the template.

```heex
<.form for={@search_form} phx-submit="search">
  <div class="flex w-50 space-x-2 mb-4">
    <.input field={@search_form["search_query"]} type="text" />
    <.button>
      Search
    </.button>
  </div>
</.form>
```

Lastly, to wire this up, all we need is to add another `handle_event` definition for our `search` event.
We already have an `apply_params` function that merges new query params in, drops keys with empty values, and then calls `push_patch/2` to our URL with the updated params.

```elixir
# lib/task_app_web/live/todo_task_live/index.ex
@impl true
def handle_event("search", %{"search_query" => _search_query} = params, socket) do
  {:noreply,
   socket
   |> apply_params(params)}
end
```

And that's it!
Our LiveView is already set up so that our query params get passed to our `list_tasks` action which now knows how to handle our `search_query`.

## Mission Accomplished

Obviously this is just scratching the surface of what can be done, but we did what we set out to do here.
First of all, we actually added some proper full text search to our app, complete with the quality of life features we wanted.
Next, we got a taste of what it was like to do some things that Ash doesn't already handle for us.

Overall, it was pretty smooth, and it didn't feel like I had to fight the framework at all.

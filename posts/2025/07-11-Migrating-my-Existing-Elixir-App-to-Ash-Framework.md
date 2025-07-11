%{
  title: "Migrating my Existing Elixir App to Ash Framework",
  author: "Matt",
  tags: ~w(elixir phoenix ash),
  description: "I migrated a personal project to use Ash, here's how it went."
}
---

I've been interested in the [Ash Framework](https://ash-hq.org/) for a few years.
Over the past month, I've gotten a chance to go through the excellent [Prag Prog book](https://pragprog.com/titles/ldash/ash-framework/), and I felt ready to take it for a spin.
I decided to convert an existing Elixir project to use Ash and just see what happened.

## What is Ash Anyway?

Ash is a framework for your domain itself.
You describe what things are, what actions you can take, and how they relate to other parts of your domain; Ash handles the implementation.

The basic building block is a *resource*, where you declare *attributes* and *actions* among other things.
For example, let's say we have some resource called `TodoTask`, we can describe it like this:
```elixir
defmodule TaskApp.TodoTasks.TodoTask do
  use Ash.Resource, ...

  resource do
    attributes do
      integer_primary_key :id
      attribute :title, :string do
          allow_nil? false
      end
      attribute :status, TodoTask.Status
      attribute :archived?, :boolean, default: false do
          allow_nil? false
      end
      attribute :body, :string
      attribute :priority, :integer
      create_timestamp :inserted_at
      update_timestamp :updated_at
    end
  end
end
```

Now all we have to do is add some actions:
```elixir
    actions do
      defaults [:create, :read, :update, :destroy]
      accept [:title, :status, :body, :priority, :archived?]
    end
```

From just this little bit of code, Ash gives you structs, migrations, changesets, and functions for reading, writing, and deleting instances of this resource.

Ash is insanely powerful, and this is just the tip of the iceberg.

## The Project We're Working With

The project we're working with is a simple personal project that I use for managing tasks, creatively named TaskApp.
You have your basic *tasks*, which are something you want to do, and different *contexts* that tasks relate to.
This lets me easily see only tasks that are related to Work (my day job) while I'm at work, without putting my attention on things that I want to do for personal projects, or just other aspects of life.

![A view of our Task App](/assets/task_app_list.png "A view of our Task App")

## Getting Started

The first step was just installing Ash and getting the basic pieces set up.
Luckily, Ash makes this as easy as possible with their Igniter tool.
Igniter combines code generation, code modification, and scripting so that you can run one command to add a package to your dependencies, patch your config, and generate any other necessary files.

Now, it was actually time to add our first domain and resource.
TaskApp has an *intake* area, which is a place to quickly add a note to yourself that you will create a full fledged task from later.
The `IntakeItem` is very simple and self-contained, so I figured it would be the easiest place to start.
All I had to do was take the existing Ecto schema and convert it to an Ash `Resource`.

```diff
 defmodule TaskApp.Intake.IntakeItem do
-  use Ecto.Schema
+  use Ash.Resource, otp_app: :task_app, domain: TaskApp.Intake, data_layer: AshPostgres.DataLayer

-  @type t :: %__MODULE__{
-          id: integer() | nil,
-          body: String.t() | nil
-        }
-  schema "intake_items" do
-    field :body, :string
-    timestamps(type: :utc_datetime)
-  end
+  postgres do
+    table "intake_items"
+    repo TaskApp.Repo
+  end
+
+  actions do
+    defaults [:create, :read, :update, :destroy]
+    default_accept [:body]
+  end

+  attributes do
+    integer_primary_key :id
+    attribute :body, :string do
+      allow_nil? false
+    end
+    create_timestamp :inserted_at
+    update_timestamp :updated_at
+  end

+  validations do
+    validate string_length(:body, min: 3)
+  end
 end
```

Once I was done, I was able to create the initial snapshot using `mix ash.codegen --snapshots-only`.

Next, I wanted to convert the context module into an Ash `Domain` and define my code interfaces.
My process was pretty simple and effective.
I took each function in my `Intake` context module, commented it out and ran my now-failing tests.
Then I defined an interface function with the same name, re-ran my tests, made some minor tweaks, and I was back to green.

For example, a function like this:
```elixir
@spec get_intake_item(integer()) :: {:ok, IntakeItem.t()} | {:error, :not_found}
def get_intake_item(id) do
  IntakeItem
  |> Repo.get(id)
  |> case do
    nil -> {:error, :not_found}
    intake_item -> {:ok, intake_item}
  end
end
```
gets replaced with this:
```elixir
  define :get_intake_item, action: :read, get_by: :id
```

The minor tweaks usually were pretty minor, like now matching on `{:error, %Ash.Error.Invalid{}}` instead of `{:error, :not_found}`, or changing the name of a function call from `list_intake_items` to `list_intake_items!`.
Since Ash uses Ecto under the hood, everything that currently reads from this table works correctly.

Once we had these new interfaces set up, we added `AshPhoenix` to support our forms and updated our LiveView.
`AshPhoenix` can derive your forms, so when I defined a `create_intake_item` interface function, my live view can just call `Intake.form_to_create_intake_item/1`, and pass its output into `to_form` like I normally would with my Ecto changeset.
My validation handler now calls `AshPhoenix.Form.validate(form, params)`, and my save handler calls `AshPhoenix.Form.submit(socket.assigns.form, params: intake_item_params)` and I'm good to go.

Once we're done there, we can go ahead and delete my now-unused `IntakeItem.changeset/2` and `Intake.change_intake_item/2` functions.

After that, we just migrated our Phoenix-generated `intake_item_fixture` into our new `Generator` module, making it easy to generate data for our tests.

That was it!
We had our first domain and resource.

## Smooth Sailing

Most of the rest of the project continued on the same way.
1. Look at our models and relationships, find a leaf node, add the resource and domain.
2. Take the database snapshots.
3. Migrate our text fixtures into generator functions.
4. One by one, convert the functions in our context module, making small changes along the way.
5. Update our form components and LiveViews to use `AshPhoenix` forms.
6. Remove any now-unused code.
7. Repeat, with the next leaf node.

## The Tricky Parts

Most of this process was pretty easy, but we did hit a few speed bumps.

### Issues With Test Data

My existing test fixtures were created by Phoenix generators, which relied on creating a struct and calling `Repo.insert/2`.
This didn't always work out; usually there were issues around missing timestamps.

Trying to use `Repo.insert/2` with a struct created by an Ecto schema seems to handle this fine, but using a struct created by an `Ash.Resource` doesn't.
The fix here was pretty simple, I would add the generator, update my test fixture to pass its arguments into the generator function, and I was good to go.

### Actions That Don't Fit

My first real question was what to do with a basic query function like this?

```elixir
@spec intake_items_count :: integer()
def intake_items_count do
  from(i in "intake_items", select: count())
  |> Repo.one()
end
```

It doesn't fit into any of the basic CRUD actions.
Luckily, Zach Daniel, the creator of Ash, is pretty responsive on Elixir Form and answered my question.
Either just leave it as a plain function, or add a generic action to your resource, like this:

```elixir
action :count, :integer do
  run fn _input, _context ->
    Ash.count(__MODULE__)
  end
end
```

### Forms For Existing Records

This was the only real headache I had in the whole process.

When you create or update a `TodoTask`, the form lets you select which `Context`s your task is for.
This is a many-to-many relationship where we add a row in a join table for each `Context` your `TodoTask`.

The existing implementation was pretty simple, each checkbox has a `value` set to the `id` of the context, and the data that we submit looks like this:

```elixir
%{ "task" => %{ "name" => "...", "contexts" => [ "1", "2" ] }}
```

I had a hell of a time getting this working.
Everything I tried either populated the form values properly, but caused the form to fail validation, or allowed for a valid form but not populating the existing values.

Thankfully, Zach was willing to go back and forth with me on an Elixir Forum thread, over the course of a few days and 20+ messages, and we found a working (but hacky) solution.
When I wrote up a guide with the solution, Rebecca Le (the author of the above mentioned Prag Prog book) pointed out how I was making this more complicated than it needed to be.
I was able to ditch the workaround and everything worked right out of the box.

```elixir
create :create do
  # ...
  change manage_relationship(:context_ids, :contexts, type: :append_and_remove)
end
```

### Wrapping Up

Migrating this project was an overall success.
For an app this simple, Ash might not provide any game-changing benefits, but it was a great learning experience.

A small personal project like this is a perfect place to experiment.
The whole process was an easy way to get some reps working with Ash, getting comfortable with the docs and guides.
Most importantly, it was a good chance to find out what concepts didn't quite click when I was working through the book, and get a better feel for what did.

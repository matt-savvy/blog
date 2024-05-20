%{
  title: "Creating LiveSlides",
  author: "Matt",
  tags: ~w(elixir phoenix liveview),
  description: "Creating LiveSlides"
}
---

This month, I've been working on a small project I'd been itching to get started on, **LiveSlides**.
This week, I've gotten the MVP out the door and am excited to write a little about it.

## What is LiveSlides?

LiveSlides is a web app that lets you create slide decks in Markdown and present them to the audience in their own browser.
You start the presentation, share a link, and then as you're presenting, changing the slide will also update the view in each audience members' browser.
And, when the presentation is finished, they'll get controls for themselves to review your slides as much as they want.

Although no Organization features have been implemented, it's trivial to have multiple presenters, removing the need for someone else on the call to advance your slides.

## Why LiveSlides?

The main benefits for the audience is that they can see everything on their own browser, giving them control over zooming in or out for their own needs, taking screenshots, and not being dependent on the resolution of a video call or projector.
They're also guaranteed to have the slides right there as soon as your presentation is finished, so if you want to include links to resources, they won't have to try to track those down after the fact.
And mostly, just because I thought it was a neat idea.
I've had the idea for over a year, and I recently completed a project (that I have yet to write up) that had a lot of similar mechanisms, so it felt very natural to jump into this.

## The Process

My last project, I let the scope wander and I was working on it for what felt like forever.
When I finished and looked back at the commit history, it was only from March 24 to April 28.
But those are just points on the calendar, I have no idea how much time I actually invested.

I was not only curious what the total hours look like for a reasonably contained project, but also if I could use this as a way to regulate the scope.
The goal was 20 hours to create the MVP:
- CRUD views for creating a slide deck
- create a live presentation from this deck
    - presenter view has controls to advance/rewind slides and end the presentation
    - audience view subscribes to events, updating as the presenter changes slides
- convert the markdown in slides to HTML

I created a new time tracking sheet from my old freelancing template, sketched out the initial scope, and got to work.

## Implementation Details

It's written in Elixir, making use of Phoenix, LiveView, and some OTP building blocks.

## `PresentationState`

`PresentationState` is just the functional core of the live presentation.
It's a simple struct module that contains functions for getting values and changing the slides.

The slides are actually modelled as two lists, `slides` and `prev_slides`.
This is an example of "making impossible states impossible".
If I had decided to just use a single list of slides and a value to represent the current index, we have to worry about things like the index being out of bounds.

Instead, when we advance a slide, we simply pop it from `slides` and push it onto `prev_slides`.
```elixir
# starting
%{ slides: [slide_a, slide_b, slide_c], prev_slides: [] }
# after calling next_slide once
%{ slides: [slide_b, slide_c], prev_slides: [slide_a] }
# after calling next_slide again
%{ slides: [slide_c], prev_slides: [slide_b, slide_a] }
```

These are the most natural operations for Elixir's lists, and also allows us to change slides and get the current slide in constant time.

## `PresentationServer`

When it's time for the live presentation, we put this `PresentationState` into a `GenServer` (`PresentationServer`), which now is our single source of truth about the Presentation.
This is how we make sure that everyone is seeing the same slides at the same time.

We need to register the process by `id` in some way so that we can later interact with this GenServer *without knowing the `pid`*.
Since we want to be able to run this app in a cluster, we need to do this in a way that will work across multiple Elixir nodes.

The built in Erlang `:global` module gives us everything we need.
When starting the GenServer, we register using opts `name: {:global, some_id}`, and then we can interact with that GenServer using the same tuple (instead of a `pid`), regardless of which node the process is running on.

```elixir
defmodule LiveSlides.Presentations.PresentationServer do
  use GenServer, restart: :transient

  def start_link({id, deck_or_presentation}) do
    GenServer.start_link(__MODULE__, [id, deck_or_presentation], name: name(id))
  end

  def name(id) do
    {:global, global_id(id)}
  end

  defp global_id(id) do
    {:presentation, id}
  end
```

The Erlang `:global` registry is something I just recently used in another project.
It was very fresh in my mind and it was easy to set this up.

## Supervision

When we start the presentation using `present/1` in our `Presentations` context, we start it under a `DynamicSupervisor`.
A `DynamicSupervisor` gives us everything that we want from a `Supervisor`, but expects to have children dynamically added and removed at runtime, instead of all listed at startup.

The most important aspect is that our `PresentationServer` won't be tied to the process that started it, but instead will live in its own designated part of the supervision tree.

```elixir
def present(deck) do
  with {:ok, %{id: id}} <- create_presentation(deck),
    {:ok, _pid} <-
       DynamicSupervisor.start_child(supervisor(), {...}) do
    {:ok, id}
  end
end

defp supervisor do
  Application.get_env(:live_slides, :supervisor, PresentationSupervisor)
end
```

We use `supervisor/0` to read from the `Application` env so we can set a different supervisor at test time.
We just need a few setup functions in `LiveSlides.TestSupervisorHelper`.

```elixir
def set_env_test_supervisor(_) do
  Application.put_env(:live_slides, :supervisor, TestSupervisor)

  on_exit(fn ->
    Application.delete_env(:live_slides, :supervisor)
  end)
end

def start_test_supervisor(_) do
  start_supervised!({DynamicSupervisor, name: TestSupervisor})
  :ok
end
```

We start `TestSupervisor` using `start_supervised!` here because it guarantees us that the process will to exit before the next test starts.
This way, as long as any tests starting presentations are not using `async: true`, every test gets a `DynamicSupervisor` with a clean slate.

We add these to our relevant tests with `setup_all :set_env_test_supervisor` and `setup :start_test_supervisor`.

## Converting Markdown

We use `MDEx` to convert Markdown.
It's exactly what we use for this blog and I've used it in another different project, so it was a breeze to add a `markdown_block` to my `core_components.ex`.
As usual, the only headache is getting it to play nicely with the TailwindCSS reset.

```elixir
def markdown_block(assigns) do
  ~H"""
  <div class={...}>
    <%= @body |> md_to_html |> HTML.raw() %>
  </div>
  """
end

defp md_to_html(nil), do: nil

defp md_to_html(body) do
  MDEx.to_html(body)
end
```

## The LiveViews

LiveSlides uses LiveView.
The same LiveView powers three live actions:
- `:present` - the view for a presenter, with controls
- `:live` - the view for an audience member, no controls
- `:view` - the view for when the presentation has ended, with personal controls

`:present` and `:live` actions each subscribe to a Phoenix PubSub topic for the presentation.
When a slide is changed in the `PresentationServer`, it broadcasts a `{:slide_changed, slide}` message with the slide itself.
Each LiveView just needs to read the body from the `Slide`, and update its own `body` in the `assigns`.

```elixir
@impl true
def handle_info({:slide_changed, slide}, socket) do
  %{body: body} = slide
  {:noreply, socket |> assign(:body, body)}
end
```

## Solo Viewing

When a presentation has finished (or a presenter is doing a practice run), the `PresentationState` just goes directly into the `assigns`.

```elixir
def apply_action(socket, id, :view) do
  state =
    id
    |> Presentations.get_presentation!()
    |> PresentationState.new()

  title = PresentationState.title(state)
  %{body: body} = PresentationState.get_slide(state)

  socket
  ...
  |> assign(:state, state)
end
```

Since a LiveView is a `GenServer`, there's no need for us add the overhead of another `GenServer` and PubSub topic.
Changing slides for a solo viewer is just a state transformation.

```elixir
case socket.assigns.live_action do
  :view ->
    next_state = apply(PresentationState, action, [socket.assigns.state])
    %{body: body} = PresentationState.get_slide(next_state)
    {:noreply, socket |> assign(:state, next_state) |> assign(:body, body)}

  ...
end
```

## TDDing LiveViews

I have some experience with testing LiveViews, but I catch myself treating these as some kind of second-class citizen, where they only get tested as an afterthought.
Since it's so easy to test in the browser as you're iterating, it's also so easy to never write these tests.
And since you never do it, you never get those much needed reps.

This project was my first experience really trying to do TDD with LiveViews, and for the most part, it was actually fun and easy.

```elixir
test "change-slide buttons update PresentationServer state", %{conn: conn, deck: deck, id: id} do
  [first_slide, second_slide | _rest] = deck.slides
  {:ok, live_view, _html} = live(conn, ~p"/presentations/present/#{id}")

  assert live_view |> has_element?(@next_button_selector)
  assert live_view |> has_element?(@prev_button_selector)

  assert first_slide == PresentationServer.get_slide(id)
  assert live_view |> element(@next_button_selector) |> render_click()

  assert second_slide == PresentationServer.get_slide(id)
  assert live_view |> element(@prev_button_selector) |> render_click()
  assert first_slide == PresentationServer.get_slide(id)
end
```

## The Results

I reached the limited feature set under the 20 hour mark, in just about two weeks.
I spent the next handful of days and sessions going beyond that and dipping into my stretch goals.

Except for one late-night session where I was on a roll, the majority of my sessions on this project were around 60-90 minutes.
For a personal project outside of work, aiming for a one hour time block, more days than not, ends up hitting the sweet spot.
It's enough time to get your brain fully immersed in the context, but not enough to leave you drained afterwards.
A quick session like this usually has me excited to come back and tackle the next piece.

I kept track of everything in a single plain text file - where I left off, next steps to tackle, and new ideas.

At one point, I realized I tried to bite off too much at once (handling all three presentation live actions) and wasn't happy with how it was modelled (what was stored on the live view and what was stored in the `PresentationServer`).
I took five minutes and a sheet of paper, sketched it out again from scratch, and drew boxes around pieces that weren't part of the original scope.
I noted these as stretch goals, made sure my new design wouldn't rule them out, and then pretended that they didn't exist.
I checked out a new branch from a much earlier commit, threw away a good pile of work, and got to work on my updated design.
And it felt great.

## Check it Out

You can play with it on [live-slides.fly.dev](https://live-slides.fly.dev/) or check out the [source code on Github](https://github.com/matt-savvy/live-slides)


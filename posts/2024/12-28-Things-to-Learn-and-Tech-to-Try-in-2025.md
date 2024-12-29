%{
  title: "Things to Learn and Tech to Try in 2025",
  author: "Matt",
  tags: ~w(),
  description: "My personal list of things I'd like to give attention to in the coming year."
}

---

Now that we're in the last few days of 2024, it's a good time to take a step back and think about what we want to focus on in the next year.
When it comes to programming and technology, this is my personal list of what I'd like to give attention to in 2025.

## Computer Systems / Computer Architecture

I'm a self-taught software engineer.
As someone who doesn't have a CS degree, I am always aware of the important areas that I was never exposed to.
As someone who's always used languages with automatic memory management, I've never been forced to think a lot about these things.
And even though I want to continue to work primarily in higher-level (and usually functional) languages, I still think it's important to remedy this.

I'm not totally clueless in this department, but this is an area that is a safe and solid investment of my time.

Mainly, I want to continue reading through [Computer Systems: A Programmer's Perspective](https://csapp.cs.cmu.edu/), brush up on some assembly, and write a non-trivial project using a lower-level language.

If you need any reason to get motivated to brush up here, check out:
- Casey Muratori on [Software Unscripted](https://open.spotify.com/episode/2TaWQgDpCxxa2edomzCUyg)
- Jonathan Blow's talk [Preventing the Collapse of Civilization](https://www.youtube.com/watch?v=ZSRHeXYDLko)

## Roc

The [Roc](https://www.roc-lang.org/) programming language is something that I've been following for a couple years now.
Started by Richard Feldman, it's aiming to be like [Elm](https://elm-lang.org/), but for all the other domains.

I'm a big fan of Elm, and an even bigger fan of the experience of *writing* Elm.
I've always been wanting to get a similar experience when working on things that aren't front-end web apps.
Roc actually has the potential to do this in a way that Haskell or Rust never will.

Roc is still pre-1.0. It's not even at a numbered release yet, just nightly builds.
That being said, it's (allegedly) usable enough already.
Once or twice I've downloaded it and played around a little, but I've never gone through the whole tutorial or built any projects.

Ideally, I would like to try it out for a project or two and see what the feel is.

If the feel is there, the language has the potential to be a real game-changer.

## Ash Framework for Elixir

[Ash](https://ash-hq.org/) is a framework to use for modeling the domain of an Elixir app.
Another piece of tech that I've kept my eyes on and fiddled with once or twice, but never properly dove in.

Ash lets you define the main elements of your domain, and it handles the rest, making sure everything behaves in a consistent, predictable way.
The upside is that it can do a ton for you, but the trade-off is that there is a steep learning curve.
It being a niche within a niche, it's not like there are tons of resources out there besides the official documentation.

The beta for the PragProg book *Building Web Applications with Ash* will apparently be available in 2025.
When that comes along, I'd like to work through it and then potentially use it for a project (or refactor an existing project I have to use it).

This is another one on the list that could fall into that "game-changing" category.


## Zig

The [Zig](https://ziglang.org/) language is a systems-level language with three big selling points.

First of all, it integrates with C and C libraries, but doesn't depend on them.
Second, there's no hidden control flow; which means errors as values instead of runtime exceptions.
Third, it's an explicit goal for the language to stay small.

Zig is another language on this list that's pre-1.0, and while it has the potential to be a game-changer for some industries, I don't think I'm in it.
That being said, my main goal with Zig would be more to use it as a way to reinforce the top item on this whole list: Computer Systems.
I think would be a great thing to use for a hobby project and to spend time at the systems level, without the baggage of C.

## 3 Elixir Books

Two years ago I started writing Elixir full time at work and my goal each year has been to work through (at least) 3 books.
I see no reason to change that in 2025. As of right now, those three books are:

### [Engineering Elixir Applications](https://pragprog.com/titles/beamops/engineering-elixir-applications/)
*Navigate Each Stage of Software Delivery with Confidence*

Our industry seems to know how to containerize an app that uses a shared-nothing architecture and then roll it out to a Kubernetes cluster, where the implication is that it could re-start or be scaled up or down on-demand.
But part the selling point of running code on the BEAM is that you have the ability to start, re-start, and scale at the granularity of individual processes.
What about any long-lived processes that are now getting mercilessly killed by your cluster auto-scaling?

How are we supposed to use a modern DevOps approach without losing Elixir's special sauce along the way?
This book is attempting to fill that knowledge gap in our industry.

### [Network Programming in Elixir and Erlang](https://pragprog.com/titles/alnpee/network-programming-in-elixir-and-erlang/)
*Write High-Performance, Scalable, and Reliable Apps with TCP and UDP*

Network Programming has never been my speciality by any means.
I know my way around handling client/server requests and responses, but I've never done anything at the level of parsing packets or picking protocols.

This book looks like a promising way to do some of that, in Elixir.

### [Real-World Event Sourcing](https://pragprog.com/titles/khpes/real-world-event-sourcing/)
*Distribute, Evolve, and Scale Your Elixir Applications*

I've been interested in using event-sourcing for a while, and have modeled a few things in an event-sourced manner.
At my day job, we use a lot of event sourcing, but I showed up after it was already all set up.

This book looks like it has a healthy balance of rules and theory as well as practical how-to knowledge.

## How to Think About This Kind of List

This time next year, will I be an expert on all these subjects?
Doubt it.
Will I have been able to follow through on all of them as much as I'd like to now?
Probably not.
Is there going to be some other exciting thing that comes on my radar?
Maybe.

I think about this list like a big menu that I can order from when I'm feeling inspired to jump into something new.
I also think of it as a way to keep myself from getting swept up and diving into whatever seems exciting at the time.

And lastly, it's a nice way to give myself permission to actually sit down and bite into some of these things that have been on my radar a year or two.
If you're still excited and interested in something and your thoughts keep coming back to it, eventually it does go from being a distraction to being your focus.

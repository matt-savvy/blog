%{
  title: "What an Industry-Changing Programming Language Would Look Like",
  author: "Matt",
  tags: ~w(software-development),
  description: "Imagine a programming language that could 10x the quality of software and reduce development and maintenance costs, what properties would it have?"
}
---

Imagine that a new programming language came along that transformed the industry.
It 10x'd the quality of the software written.
It drastically reduced the time it takes to write and maintain code, especially with large, distributed teams.

What would this programming language look like? What properties would it have?

## Guarantees

In order to achieve a huge leap forward in quality, `$LANG` is going to need to be make as many guarantees as possible, before the code is ever run.
There's no two ways around this, you just can't to expect to run every code path.
A program crashing should be incredibly rare.

This is probably going to require a few things.

### Pre-Run Checks

The simplest version of this is just a series of checks at compile-time.
I'm not going to say that `$LANG` will be compiled all of the time, there are plenty of times that it makes sense to not be, but in order to run code in production, you'll need to have gone through some pre-flight checks.
It could be that running your static analysis and tests produces an artifact that is deployed or distributed with your program, and the program requires that in order to start.

### Type Checking

If we want to get where we're going, it's simply no longer acceptable to have runtime errors because someone made a mistake and tried to use a string where the program expects a number.
Maybe `$LANG` will offer some sort of dynamic typing that is able to narrow things down, or maybe it will use a static type system, but it's got to make sure that our code is at least all valid.

### Undefined Behavior

It's also just not going to cut it to have undefined behavior.
If you have a legal `$LANG` program, everything that it does should be clearly defined.

### Rules Engine

`$LANG` is going to need first-class support for a rules engine like [Credo](https://hexdocs.pm/credo/overview.html) or [elm-review](https://package.elm-lang.org/packages/jfmengels/elm-review/latest/).
This can't be an nice-to-have side project, this needs to be built in from the ground up.

## Development and Maintenance

Having these guarantees about your code is already going to be a shot in the arm for developer productivity, but we're going to need more than that to change the world.

### Fast Compilation, Fast Feedback

Like I said above, it's probably not viable for `$LANG` to only be compiled.
A developer environment is most likely going to need to be able to run and interact with code in a more ad-hoc fashion.

The important qualities here is that compilation will need to be fast, but also allow you to run and experiment with incorrect or incomplete code.
This might involve a development mode that warns you about your issues but still allows you to incrementally test things.

This prevents issues we see in languages like Go, where you're forced to comment out lines or rename vars to a blank identifier (`_`) while testing incremental changes.

### Debug-able and Observable

It's also not going to be acceptable to have a have a system that's difficult to debug or observe the state of.
When things do go wrong, you're going to need to be able to pop open the hood and see what's going on, and you're going to need to be able to do this while the system is running.

### First Class Testing

`$LANG` is going to need to be built from the ground up with automated testing in mind.
In order to test effectful code, you shouldn't need crazy or convoluted approaches.
When testing code that's supposed to run across long scales of time, any one test should be able to freeze time, or set the clock to essentially any point in time.
And this all needs to happen while guaranteeing that no one test is going to interfere with any other tests running.

It's also going to need great support for fuzz-testing, property-based testing, formal methods, and autonomous testing like [Antithesis](https://antithesis.com/).

It probably goes with out saying, but it's also going to need to understand what source code has changed so we can re-run only the tests that are going to have different results.

### Tooling, Exposed ASTs and More

No one knows what the next fifty years will bring, but I am pretty sure that `$LANG` will need to expose the Abstract Syntax Tree and tools to work with it.
The bare minimum here is that an external tool should have an standard interface to generate, patch, and remove code.
Things like autoformatting or detecting and removing dead code are table stakes.

The next fifty years will see plenty of code written by other programs (although they will *not* be LLMs), and it's not going to move the needle if they only interact with the source code in text format.
We should be able to work with the textual representation of the program, as well as it represented in data, and go back and forth.
`$LANG` is going to need to be built from the ground up to be written and maintained by both humans as well as machines.

### A Minimal Set of Features

`$LANG` is going to need to empower teams to operate at the next level too, not just the individuals on them.

This means a minimal set of features, minimal syntax sugar on top of it, and a clearly defined right way and wrong way to do things.
There should never be any situation where an author has to decide between `some_var.a`, `some_var["a"]`, or `get(some_var, "a")`.

Likewise, a team should never have to spend their time debating over which of these to use, or what subset of features they use or don't use.
This might mean that the standard library is robust, but optional.

### A Path to Evolve

In order to keep the set of features minimal without expecting `$LANG` to be perfect out of the gate, there needs to be a path for the language to evolve.
This is going to involve adding new features and removing old ones.

This might mean that part of releasing a new feature involves some tooling to migrate your code to the new version, and this process becomes as common as database migrations are today.

### Granular Packaging

I've written recently about dependencies in [The Way We Handle Dependencies Is a Sick Joke](posts/2025/04-18-The-Way-We-Handle-Dependencies-Is-a-Sick-Joke.html), and for all these reasons, `$LANG` is going to need to take a different approach.

Maybe this will look something like how [Unison](http://unison-lang.org/) treats each single function as its own distributable atom, each as its own uniquely identifiable version.
Or maybe it will be something totally different.

But in order to really change the game, `$LANG` will need to make these problems go away entirely.
Developers will need to be delivered from dependency hell.

This means not depending on an entire package when we only use some parts of it.
This also means not downloading it, re-compiling, and re-checking it over and over.
And there needs to be a road for gradual, sane updates.

We'll need a paradigm where developers can leverage each other's work and library authors can move fast without that just creating work for library uses.

## Runtime Characteristics

We've talked about program quality and the developer experience, but what might we need to see from a runtime perspective?

### Fast

This is a no-brainer.
It's going to need to be fast.
When compiled, probably as fast as C.

In fact, it's probably going to need to be designed from the ground up for compiler optimization.

### Manual and Automatic Memory Management

In addition to speed, `$LANG` will also need to offer both manual and automatic memory management.
In order to truly change the industry, it's going to need to offer the control that any of the low-level languages already out there can give you.
Otherwise, it's never going to be the right choice for operating systems, databases, or any other serious systems-level work.

But it also is going to need to support automatic memory management, or it's not going to be the language of choice for high-level applications either.

### Secure

I'm no security expert, but I can only imagine `$LANG` will need to raise the bar compared to what we have today.
If we're talking a 10x improvement in quality, being secure is part of that quality.

### Concurrency

The future is only going to involve more and more parallelism, and `$LANG` will need to embrace that as well.
It needs to be easy to do and hard to do wrong.

## How These Qualities Could Change the Industry

First, any language that's as fast as what's already out there will be a candidate for re-writing or re-implementing existing software in.
Look at how many projects that are copies of existing projects, except just re-written in Rust.
Or how much Javascript tooling is written in Go, Rust, or even Zig.

Next, add in guarantees about crashless software, improved security, and program correctness, and you'll have believers.
If you can ship something that you can be this confident about, the economics will justify the choice.
Early adopters will have to do more work, but they'll also have a competitive advantage.
On a long enough timeline, a team that can ship something right the first time, every time, will overtake the entire field.

The other aspects of `$LANG` will be like rocket fuel for developer productivity, turning those believers into straight up fanatics.
Imagine how fast your team could move when everything is actually easy to write, easy to debug, easy to test, easy to check, and easy to maintain.

It's not clear to me if one language could actually have all of these qualities, but I do know that we are nowhere near the peak of what's possible.

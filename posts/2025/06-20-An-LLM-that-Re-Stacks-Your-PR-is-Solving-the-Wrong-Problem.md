%{

  title: "An LLM that Re-Stacks Your PR is Solving the Wrong Problem",
  author: "Matt",
  tags: ~w(git AI LLM),
  description: "Why I think that if you are reaching for an AI to rewrite your Git history, you've already messed up."
}
---

This morning, I saw a post on HN about a [Tool to Automatically Create Organized Commits for PRs](https://news.ycombinator.com/item?id=44324457).
What this does is take the overall diff you want to ship, sends it to an LLM, and automatically rewrites the history of your branch.

From their README:

> **Before** (your typical feature branch):
```
* 7f8d9e0 fix tests
* 6c5b4a3 typo
* 5a4b3c2 more auth changes
* 4d3c2b1 WIP: working on auth
* 3c2b1a0 update tests
* 2b1a0f9 initial auth implementation
```

> **After** (AI-organized commits):
```
* a1b2c3d feat: implement complete authentication system with JWT tokens
* e4f5g6h test: add comprehensive test coverage for auth endpoints
```

---

I think tools like this are not only not needed, but are counter-productive and are another example of devs not knowing *how* to work.

## This Workflow is a Sign That You've Already Messed Up

Let's talk about the starting assumption, which is that your branch is a mess of haphazard changes.
Forget about the commit messages for a minute.
How did you get here in the first place?

There's only really three ways you're going to end up here.

One is that you did your work in a reasonable, methodical way, but went out of your way to add and commit random changes together.
My guess is that's not the case.

Another option is that you still did your work in a reasonable, methodical way, but you don't have a clear philosophy of what you commit and when.
I've worked with people who just use commits as a save point when they have to switch gears and do something else.
In my experience, the guys who work like this are not very structured or deliberate in their work in the first place.

Which leaves the most likely scenario: you wound up with a branch of haphazard commits because you did your work by making a bunch of haphazard changes.

## Developers Don't Know How To Work

When I say that a lot of developers don't know *how* to work, this is exactly what I'm talking about.

Whether it's tried and true write-the-test-first TDD or there's not even a test suite in sight, there's an underlying constant.
All other things being equal, it's always going to be more effective to minimize work in progress.
This means reducing the amount of time your code stays in a broken state between changes.

This usually means going from working code to working code, step by step.
How small are those steps?
That depends on the changes you need to make, how confident you are in them, and how quick it will be to verify them.

If you are very comfortable with the language you're working in, doing something that you think is trivial, and have good tests and tooling, the most effective way to make that change might be to write it in one shot, and then run it.
A language that you're just learning?
Maybe it's going to be working in a REPL, one line at a time until you think you've got it working.

What about when you don't even know where you're going?
You're still going to be more effective by taking a step in the direction you think you need to go, making sure that had the effect you thought it would, and then judging if this got you closer or not.

## It's Not About The Commits

While I do think [Atomic Commits](/posts/2024/10-06-What-Makes-a-Commit.html) are important, and that you should carefully [Craft Your Commits](/posts/2024/10-13-Crafting-Perfect-Commits-In-An-Imperfect-World.html), most of the time, these things emerge naturally as a result of doing your work in the right way in the first place.
If you do it right, well-structured and atomic commits are a byproduct of your work.

The reason it's a bad idea to commit unrelated changes together is partially for making the overall diff easier to understand, partially to make each piece easier to revert or extract into a separate series of changes, but there's a more obvious reason.
It's because it's a bad idea to be working on unrelated changes at the same time!

Even more so if this leaves your code in an unusable state.
If you can't run or test your code, you can't get as much feedback about what you've changed.
Then, when you get back to a working state, there's going to be more for you to validate and a larger surface area of things you might need to address.

You've also lost any isolation between these unrelated changes, which makes it harder for you to know where any problems are.
This isolation is at the heart of the scientific method; you change one thing and observe the results.

If you've ever done any pair programming with me, you've probably heard me say "hold on, one thing at at time" plenty of times.
This goes for both when you have a small interruption or are trying to write three different parts of a feature all at once.

## Handling Quick Tangents

When you are knee-deep in adding some functionality or fixing a bug and you're triggered by an unrelated refactor that you just *have* to make, there's two easy solutions here.

One approach is is to stash your changes, quickly make your refactor, and then pop your changes.
This is where being comfortable and confident in Git comes in.
If you have a good mental model and you know what you're doing, it's trivial to stash your work in progress, make your refactor, test it, add and commit it, and then restore your work in progress.
The whole detour should only take a few seconds longer than the actual refactoring and testing.
And you know what?
If something doesn't go quite right with that refactor, you'll be grateful that there aren't other unrelated changes there.
Not only will debugging be easier, but if you decide to abandon that refactor, you can quickly discard those changes without messing up any of your other work in progress.

The other solution, and this is high tech stuff here, is to take a second or two and write it down.
This is where having a notebook by your desk or a notes.txt on quick draw can be super helpful.
My Vim config has a keymap to open a long-running plain text file.
Combine this with a keymap to yank the file and line number and you've got yourself a way to add a note to yourself with the exact location, in just a matter of seconds.

## Using an LLM to Tell You What You Did

Using a tool like this is like having an AI record every action you take and using that to generate an answer when your wife asks "How was your day?"
It totally misses the point of *why* you did any of those things.

I don't want to crack open the can of worms here, but using an LLM to rewrite your history based on the overall diff seems like a bad idea.
I can see a handful of limitations, problems, and pitfalls, but I'm not even going to get into it.
Even if the workflow were perfect, it doesn't change anything.

## What I Would Rather See

At the end of the day, I don't want to review your work that was re-stacked by an LLM, and I definitely am not going to get any benefit from generated commit messages that read like LinkedIn spam:
> `add comprehensive test coverage for auth endpoints`.

Yes, I'm sure this is all very comprehensive, especially since the original last commit was titled `initial auth implementation`.

So what would I rather see instead?

First, I'd rather you just do the work the right way the first time.
But if you can't do that, just take one minute and write down what the overall changes are, and explain anything that you think might need explaining.
That's going to be much more useful than anything an LLM is going to churn out.

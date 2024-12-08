%{
  title: "Why You Should Care About Your Commits (Even If You Squash Merge!)",
  author: "Matt",
  tags: ~w(git video cheat-sheet),
  description: "Using Git well is a communication skill. Build the branches that you would want to review."
}
---

<iframe
    class="embedded-yt"
    src="https://www.youtube.com/embed/WsgkV0rSIUQ?rel=0"
    title="YouTube video player"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    referrerpolicy="strict-origin-when-cross-origin"
    allowfullscreen
>
</iframe>

## Example PRs

Take a look at the example PRs and try stepping through the commits yourself.

#### Example A
- [Version 1](https://github.com/matt-savvy/git-communication-example/pull/2)
The first file makes a change, but you have to read past several other files to see the definition of the new function call.

- [Version 2](https://github.com/matt-savvy/git-communication-example/pull/1)
You can step through the commits one at time to follow the changes easier.

#### Example B
- [Version 1](https://github.com/matt-savvy/git-communication-example/pull/4)
The diff refactors AND changes code all at once.

- [Version 2](https://github.com/matt-savvy/git-communication-example/pull/3)
The refactor and the functional changes have been split up.

## Cheat Sheet
- [`diffColorMoved` docs](https://git-scm.com/docs/git-config#Documentation/git-config.txt-diffcolorMoved)

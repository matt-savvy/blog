%{
  title: "Commit Message Writer's Block? Here's the Cure (Video and Cheat Sheet)",
  author: "Matt",
  tags: ~w(git cheat-sheet),
  description: "One crucial setting that should be in every git config."
}
---
<iframe
    class="embedded-yt"
    src="https://www.youtube.com/embed/cxapgvGkOJY?rel=0"
    title="YouTube video player"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    referrerpolicy="strict-origin-when-cross-origin"
    allowfullscreen
>
</iframe>

## Cheat Sheet

[`git commit --verbose` docs](https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---verbose) or `git commit --help`

Show a diff to help you remember what changes you're about to commit.
```bash
$ git commit --verbose
```

[`commit.verbose` docs](https://git-scm.com/docs/git-config#Documentation/git-config.txt-commitverbose)

Add `commit.verbose` to your global Git config.
```bash
$ git config --global commit.verbose true
```

Or add to your `.gitconfig` like so
```
[commit]
    verbose = true
```

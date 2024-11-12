%{
  title: "Git Bisect | Automatically Find Your Bugs",
  author: "Matt",
  tags: ~w(git cheat-sheets video),
  description: "Track down which commit introduced a bug so you can make sure it wasn't your fault. Spoiler: it was."
}
---
<iframe
    class="embedded-yt"
    src="https://www.youtube.com/embed/5NnA_Ax4LNo?rel=0"
    title="YouTube video player"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    referrerpolicy="strict-origin-when-cross-origin"
    allowfullscreen
>
</iframe>

## Cheat Sheet

[`git bisect` docs](https://git-scm.com/docs/git-bisect) or `git bisect --help`

`git bisect` does a binary search from a commit known to be good to a commit known to be bad, finding the first commit that contains the bug.

Begin bisect process.
```bash
$ git bisect start
status: waiting for both good and bad commits
```

Specify that the currently checked out commit (`HEAD`) has the bug, and that `7e01f02` is an ealier commit that did not contain the bug.

```bash
$ git bisect bad
status: waiting for good commit(s), bad commit known
$ git bisect good 7e01f02
Bisecting: ...
```

You can specify a branch or a tag instead.

```bash
# the latest commit on branch develop is good
$ git bisect good develop
# version 3.1.0 is good
$ git bisect good 3.1.0
```

Mark a commit as good or bad as the process goes along
```bash
$ git bisect good
$ git bisect bad
```

Skip over the current commit (e.g. it doesn't compile)
```bash
$ git bisect skip
```

When you are finished, return back to the commit you had checked out when starting the bisect
```bash
$ git bisect reset
```

Automate the check.
Git will run `check.sh` after checking out each commit.
- if the script exits with `0`, the commit will be marked `good`
- if the script exits with `1`, the commit will be marked `bad`
- if the script exis with `125`, the commit will be skipped

```bash
$ git bisect run check.sh
```

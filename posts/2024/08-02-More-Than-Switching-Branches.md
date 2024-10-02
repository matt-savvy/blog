%{
  title: "More Than Switching Branches |  git checkout Does Everything (Video and Cheat Sheet)",
  author: "Matt",
  tags: ~w(git cheat-sheets),
  description: "checkout all these things you can do with this one command"
}
---
<iframe
    class="embedded-yt"
    src="https://www.youtube.com/embed/jsahpR1Siis?rel=0"
    title="YouTube video player"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    referrerpolicy="strict-origin-when-cross-origin"
    allowfullscreen
>
</iframe>

## Cheat Sheet

[`git checkout` docs](https://git-scm.com/docs/git-checkout) or `git checkout --help`

### Checking Out Branches / Commits / Tags

Checkout branch `feature-123`
```bash
$ git checkout feature-123
```

Checkout branch `feature-123`, discarding changes if there is a conflict
```bash
$ git checkout -f feature-123
```

Checkout the last branch, tag, or commit you had checked out
```bash
$ git checkout -
```

Checkout commit `513ad35`
```bash
$ git checkout 513ad35
```

Checkout tag `v3.0.1`
```bash
$ git checkout v3.0.1
```

Create a new branch named `tmp` if and check it out.
Fails if `tmp` already exists.
```bash
$ git checkout -b tmp
```

Create a new branch named `tmp` if and check it out.
Resets `tmp` if it already exists.
```bash
$ git checkout -B tmp
```


### Checking Out Only a Subset of Files

Checkout the entire subtree from `HEAD`.
Effectively discards all changes to tracked files in working dir.
```bash
$ git checkout .
```

Checkout `./src` from `HEAD`.
Effectively discards changes to `src` in working dir.
```bash
$ git checkout src
```

Checkout `./src` from `feature-123` and stage changes.
Effectively updates your `./src` to be in the same state as it is on `feature-123`.
```bash
$ git checkout feature-123 ./src
```

### Resolving Conflicts

Accept all the changes from one side of a conflict.
```bash
$ git checkout --theirs .
$ git checkout --ours .
```

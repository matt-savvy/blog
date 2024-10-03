%{
  title: "Go Beyond Rebase | git rebase --interactive (Video and Cheat Sheet)",
  author: "Matt",
  tags: ~w(git cheat-sheets),
  description: "git rebase --interactive. Take it to another level. "
}
---
<iframe
    class="embedded-yt"
    src="https://www.youtube.com/embed/CQZ9nFFQArY?rel=0"
    title="YouTube video player"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    referrerpolicy="strict-origin-when-cross-origin"
    allowfullscreen
>
</iframe>

## Cheat Sheet

[`git rebase --interactive` docs](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt---interactive) or `git rebase --help`


Rebase the current branch onto `master`, interactively
```bash
# long flag
$ git rebase --interactive master
# short flag
$ git rebase -i master
```

Commands will be run top to bottom.

### Fixup Workflow

One way to make changes to a commit that's not the last commit.
Make your changes, then stage them.
Then make a fixup commit:
```bash
$ git commit --fixup <target commit>
```

Rebase onto `master`, automatically moving the fixup commit right after the target commit and targeting it for `fixup`, which will update the target commit.
```bash
$ git rebase -i --autosquash master
```

### Amend Workflow

Another way to make changes to a commit that's not the last commit.
If you get too many conflicts when using the Fixup Workflow, this can be an easier way.

Start the interactive rebase, and mark the target commit as `amend`
```bash
pick 8681b76 Fix table
amend 597e8f8 Update profile header
pick dbde947 Add contact link
```

The rebase will stop after the target commit.
Make your changes, then stage them.
Then amend the commit and continue:
```bash
$ git commit --amend --no-edit
$ git rebase --continue
```

### Splitting Up A Commit

For times where you have one commit in the history that you'd like to split up.

Start the interactive rebase, and add `break` on the line after the target commit
```bash
pick 8681b76 Fix table
pick 597e8f8 Update profile header
break
pick dbde947 Add contact link
```

The rebase will stop at the `break`.
Reset to the previous commit, leaving your changes in the working dir.
It will be as if you made all these changes and just haven't made the commit yet.
```bash
$ git reset HEAD~
```

Then stage and commit the pieces you'd like to, making as many commits as you want.
When finished, continue the rebase
```bash
$ git rebase --continue
```

### Execute A Command After Some / All Commits

Start the interactive rebase, and add `exec <command>` on the line after the commit(s) you want to run the command after.
```bash
pick 8681b76 Fix table
pick 597e8f8 Update profile header
exec go test ./...
pick dbde947 Add contact link
```

The rebase will stop at the first non-zero exit code.
Make any amends or continue with
```bash
$ git rebase --continue
```

Run `go test ./...` after every commit
```
$ git rebase master --exec "go test ./..."
```

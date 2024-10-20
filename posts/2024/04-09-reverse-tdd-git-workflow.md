%{
  title: "Reverse TDD Workflow | For When the Tests Weren't Written First (Video and Cheat Sheet)",
  author: "Matt",
  tags: ~w(git tdd cheat-sheet),
  description: "Because sometimes you need to test the test."
}
---

<iframe
    class="embedded-yt"
    src="https://www.youtube.com/embed/AtZ-hiTXmW0?rel=0"
    title="YouTube video player"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    referrerpolicy="strict-origin-when-cross-origin"
    allowfullscreen
>
</iframe>


TDD can be great, but no one follows it all of the time.
In some cases, especially bug fixes, we'll have a lapse of discipline and simply go ahead and make the change.
But then, once we've fixed the bug, we think, "We'd better go ahead and add a test for this."

So you go ahead and write a test that you _think_ covers it, but you're not sure.
And you're not going to just delete the work you just did, right?
This is where you can apply what I call the Reverse-TDD Workflow.
This applies to two main scenarios.

## Scenario A - Uncommitted Changes

In this scenario, we have made our fix and added our test, but haven't committed anything yet.
What we want to do is stage _only_ our new tests.
```bash
# stage only your tests
git add <path>
```

If you have staged other changes, you'll need to unstage them.
```bash
# unstage any other changes
git reset <path>
```

Now, we're going to stash all of our changes, but keep the staged changes.
```bash
# stash everything but keep staging as-is
git stash --keep-index
```

If you do `git status` now, you should see your tests staged but your working tree unchanged.

Now, you can simply run your tests and see how your original code works with the new test.
If your test is good, it should fail, exposing the bug you wanted to fix in the first place.
If your new test passes, you've got a problem.
But no worry, you're here, working with the original code and your new test, as if you'd written the test first.
This would be the perfect time to pump the brakes and work on your test until you can trigger the bug.

Once you're ready, bring back your stashed changes.
```bash
# restore the most recently stashed changes
git stash pop
```

If you made changes to your test while your changes were stashed, you might need to resolve some merge conflicts.

And now you can continue the rest of your work, confident in your changes and your test.

<script src="https://asciinema.org/a/652953.js" id="asciicast-652953" async="true"></script>

## Scenario B - Changes Committed

Now, in this scenario, we have made our fix and added our test and already gone ahead and committed it.
We can't use the same workflow above, but we still can accomplish the same thing.

First, we need to identify what is the last point that contains our code in the state we want to run our new tests on.
Ideally, you're working on a branch that only contains these changes.
This makes our last point `dev` or `master` or whatever other point you branched off of.

If you're not sure what that point is, take a quick look at the log to find and copy the commit hash.

```bash
# log, showing the patch (changes)
# only include commits involving <path>
git log -p <path>
```

The simplest way from here is to check out that commit, branch, or tag:

```bash
# check out the repo at a point in the history
git checkout <branch|tag|commit>
```

Next, we are going to bring our new tests into this previous point.
For example, let's say our bugfix is on a branch named `bugfix-123` and our tests are in a `test` dir:
```bash
# set our test dir to how it is on our bugfix-123 branch
git checkout bugfix-123 test
```

Now, when you use `git status`, you should see that your `test` dir has changes staged to be committed.
If you use `git diff --staged`, you should see that the changes are your new test.

So now, we are in the same place as our Uncommitted Changes workflow above; we have our new test but not our fix.
From here, we continue in the same way by running our tests and if our tests are good, it will expose our bug.

If you are happy with your test, you can simply checkout the last place you had checked out.
```bash
# check out the last branch/tag/commit you had checked out
git checkout -
```

What if you're not happy with your test and you needed to make some changes?
No problem, just stash them and reapply them when you're back to where you want to make them.
```bash
# stash your changes
git stash
# check out the last branch/tag/commit you had checked out
git checkout -
# restore the most recently stashed changes
git stash pop
```

<script src="https://asciinema.org/a/652980.js" id="asciicast-652980" async="true"></script>

## Conclusion

This workflow is helpful in a few situations, and once you are comfortable with the basic idea, you'll discover other uses and variations.
For example, when you're reviewing someone else's code and want to see for yourself that the test does indeed prove the bug is fixed.

This isn't a replacement for TDD in general, and I'm not advocating using this workflow instead of TDD.
However, when you find yourself in the situation where you have some tests and some code, you can use this workflow to get one of the big benefits of TDD - confidence that your test catches the bug and that your code fixes it.

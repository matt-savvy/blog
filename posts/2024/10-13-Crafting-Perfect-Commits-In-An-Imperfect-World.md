%{
  title: "Crafting Perfect Commits In An Imperfect World",
  author: "Matt",
  tags: ~w(git cheat-sheets video),
  description: "Your commits can be perfect even when your changes aren't."
}
---
<iframe
    class="embedded-yt"
    src="https://www.youtube.com/embed/gKSRg8lYe2c?rel=0"
    title="YouTube video player"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    referrerpolicy="strict-origin-when-cross-origin"
    allowfullscreen
>
</iframe>

Stage and commit all your changes in one go.
Ignores any untracked files.

[`git commit -a` docs](https://git-scm.com/docs/git-commit#Documentation/git-commit.txt--a)

```bash
$ git commit -a
```

[`git add <pathspec>...` docs](https://git-scm.com/docs/git-add#Documentation/git-add.txt-ltpathspecgt82308203)

Stage files based on path provided.
```bash
# stage everything in the current dir and child dirs
$ git add .

# stage just the contents of `./some-dir`
$ git add ./some-dir

# stage just the contents of `file-1.c` and `file-2.c`
$ git add file-1.c file-2.c
```

[`git add -p` docs](https://git-scm.com/docs/git-add#Documentation/git-add.txt-patch)

Interactively stage hunks.
```bash
# go through hunks of changes for all files
$ git add -p

# go through hunks of changes for only the contents of `./some-dir`
$ git add -p ./some-dir
```

Patch mode:
```diff
@@ -14,11 +14,10 @@ func isVowel(r rune, includeY bool) bool {
 		return true
 	case 'u':
 		return true
+	case 'y':
+		return includeY
 	default:
-		if r == 'y' && includeY {
-			return true
-		}
-		return false
+		return idx == 0
 	}
 }
(1/3) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]
```

Enter `?` to see all options.
```
(1/3) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]?
y - stage this hunk
n - do not stage this hunk
q - quit; do not stage this hunk or any of the remaining ones
a - stage this hunk and all later hunks in the file
d - do not stage this hunk or any of the later hunks in the file
j - leave this hunk undecided, see next undecided hunk
J - leave this hunk undecided, see next hunk
K - leave this hunk undecided, see previous hunk
g - select a hunk to go to
/ - search for a hunk matching the given regex
s - split the current hunk into smaller hunks
e - manually edit the current hunk
p - print the current hunk
? - print help
```

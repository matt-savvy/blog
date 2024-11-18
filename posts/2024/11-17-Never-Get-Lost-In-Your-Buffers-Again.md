%{
  title: "Never Get Lost In Your Buffers Again | Vim Marks",
  author: "Matt",
  tags: ~w(vim cheat-sheets video),
  description: "Use Vim marks to instantly get back to where you need to be."
}

---

<iframe
    class="embedded-yt"
    src="https://www.youtube.com/embed/Q19qKdV1n2w?rel=0"
    title="YouTube video player"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    referrerpolicy="strict-origin-when-cross-origin"
    allowfullscreen
>
</iframe>

## Cheat Sheet

[marks docs](https://neovim.io/doc/user/motion.html#_7.-marks) or `:h mark-motions`


Mark the current position in the buffer as mark `a` (local to buffer only)
```
ma
```

Mark the current position in the buffer as mark `A` (globally)
```
mA
```

Jump to mark `a` (start of line)
```
'a
```

Jump to mark `a` (line and col)
```
`a
```

Marks can be used as motions.
Change everything from current position to mark `a`
```
c`a
```

Marks can be used in command
Substitute "jpg" with "jpeg", from mark `a` to mark `b`
```
:'a,'b s/jpg/jpeg/g
```

See a list of all marks
```
:marks
```

See marks `a`, `b`, and `c`
```
:marks abc
```

Delete mark `a`
```
:delmark a
```

Preserving marks between sessions requires `shada` to be non-empty.
See [`shada`](https://neovim.io/doc/user/usr_21.html#21.3) or `:h shada`

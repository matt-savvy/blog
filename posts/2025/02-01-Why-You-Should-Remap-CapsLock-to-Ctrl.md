%{
  title: "Why You Should Remap CapsLock to Ctrl",
  author: "Matt",
  tags: ~w(vim video cheat-sheet),
  description: "The Ctrl key is super-useful, here's how to make it OP. If you were using CapsLock for anything in the first place, I don't even know what to tell you."


}
---

<iframe
    class="embedded-yt"
    src="https://www.youtube.com/embed/$HSzBJhZhjpA?rel=0"
    title="YouTube video player"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    referrerpolicy="strict-origin-when-cross-origin"
    allowfullscreen
>
</iframe>

## Links
- [Practical Vim by Drew Neil](https://pragprog.com/titles/dnvim2/practical-vim-second-edition/)
- [The True History of vi](https://lunduke.substack.com/p/the-true-history-of-vi)

## Cheat Sheet

### Insert Mode
See also [Neovim Docs - Insert Mode - Special Keys ](https://neovim.io/doc/user/insert.html#ins-special-keys) or `:h ins-special-keys`

Escape / go back to Normal mode.
```
<C-[>
```

Delete the current/previous word.
```
<C-W>
```

Delete to the start of the line.
```
<C-U>
```

Paste from register `a`, staying in Insert mode.
```
<C-R>a
```

Autocomplete
```
# next
<C-N>
# prev
<C-P>
```

### Normal Mode

See also [Neovim Docs - normal mode](https://neovim.io/doc/user/vimindex.html#_2.-normal-mode)

Increment / decrement first number after cursor on line
```
<C-A>
<C-X>
```

For Window commands, see [Vim Buffers, Windows, and Tabs Cheat Sheet](/posts/2024/08-09-vim-buffers-windows-and-tabs.html)


Go backwards / forwards through the jumplist.
See [Neovim Docs - jump-motions docs](https://neovim.io/doc/user/motion.html#jump-motions) or `:h jump-motions`
```
<C-O>
<C-I>
```

Enter Visual Block Mode
```
<C-V>
```

## Shell

Step backwards and forwards through your history.
```
<C-P>
<C-N>
```

Search backwards and forwards for `some-text` through your history.
See also:
- [bash manual - Commands For History](https://www.gnu.org/software/bash/manual/bash.html#Commands-For-History)
- [zsh manual - History](https://zsh.sourceforge.io/Doc/Release/Options.html#History)

```
<C-R>some-text
<C-S>some-text
```

Jump to start, end of line
```
<C-A>
<C-E>
```

Delete current/previous word.
```
<C-U>
```

Delete to the start of the line.
```
<C-U>
```

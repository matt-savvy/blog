%{
  title: "Vim Formatting Essentials (Video and Cheat Sheet)",
  author: "Matt",
  tags: ~w(vim cheet-sheets),
  description: "The three formatting operations I can't imagine life without."
}
---
<iframe
    class="embedded-yt"
    src="https://www.youtube.com/embed/l-kEyudr6YU?si=fgHpn4-JfOF_1OQ3&rel=0"
    title="YouTube video player"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    referrerpolicy="strict-origin-when-cross-origin"
    allowfullscreen
>
</iframe>

- [`gq` docs](https://neovim.io/doc/user/change.html#gq) or `:h gq`
- [`<<` docs](https://neovim.io/doc/user/change.html#%3C%3C) or `:h <<`
- [`=` docs](https://neovim.io/doc/user/change.html#%3D) or `:h =`

## Cheat Sheet

Format the current line
```
gqq
```

Format selected text.
Mnemonic: GQ Magazine is fashionable and this operation makes your text fashionable.
```
gq
```

Configure maximum width used by `gq` and enable auto line-breaks at 120 cols (local to buffer)
```vimscript
" vimscript config
set textwidth=120
```
```lua
-- lua
vim.bo.textwidth = 120
```

Disable `textwidth`
```vimscript
" vimscript config
set textwidth=0
```

```lua
-- lua
vim.bo.textwidth = 0
```

Shift lines one `shiftwidth` left.
```
<<
```

Shift lines one `shiftwidth` right.
```
>>
```

Use `.` operator to shift multiple levels of indentation.
```
>>..
<<..
```

Shift a paragraph one `shiftwidth` left or right.
```
>ap
<ap
```

Auto-indent selected lines
```
=
```

Auto-indent a paragraph
```
=ap
```

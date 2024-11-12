%{
  title: "Vim Formatting Essentials",
  author: "Matt",
  tags: ~w(vim cheet-sheets video),
  description: "The three formatting operations I can't imagine life without."
}
---
<iframe
    class="embedded-yt"
    src="https://www.youtube.com/embed/l-kEyudr6YU?rel=0"
    title="YouTube video player"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    referrerpolicy="strict-origin-when-cross-origin"
    allowfullscreen
>
</iframe>

## Cheat Sheet

### Formatting Lines

[`gq` docs](https://neovim.io/doc/user/change.html#gq) or `:h gq`

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

### Shifting

[`<<` docs](https://neovim.io/doc/user/change.html#%3C%3C) or `:h <<`

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

### Indentation

[`=` docs](https://neovim.io/doc/user/change.html#%3D) or `:h =`

Auto-indent selected lines
```
=
```

Auto-indent a paragraph
```
=ap
```

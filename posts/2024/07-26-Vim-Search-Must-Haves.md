%{
  title: "Vim Search Must-Haves | 5 Things Everyone Should Know (Video and Cheat Sheet)",
  author: "Matt",
  tags: ~w(vim cheat-sheets),
  description: "Some search moves that should be muscle memory for everyone."
}
---

<iframe
    width="560"
    height="315"
    src="https://www.youtube.com/embed/jd5m_rg4WmM?rel=0"
    title="YouTube video player"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    referrerpolicy="strict-origin-when-cross-origin"
    allowfullscreen
>
</iframe>

[Neovim User Manual - Search Commands And Patterns](https://neovim.io/doc/user/usr_27.html)

Search for word under cursor
```
*
```

Jump to next, prev search
```
n
N
```

Put word under cursor into search command (or other command)
```
:<C-r><C-w>
```

Substitue last search with `something_else`
```
s//something_else
```

[incsearch](https://neovim.io/doc/user/options.html#'incsearch') or `:h incsearch`.
Incrementally show where the pattern matches in the buffer
```vimscript
" vimscript
set incsearch
```
```lua
-- lua
vim.go.incsearch = true
```

[hlsearch](https://neovim.io/doc/user/options.html#'hlsearch') or `:h hlsearch`.
Highlight all matches when there is a search pattern.
```vimscript
" vimscript
set hlsearch
```
```lua
-- lua
vim.go.hlsearch = true
```

Clear those highlighted searches when you are tired of looking at them
```
<C-l>
```

Cycle through previous searches
```
/ <C-p>
/ Up
/ <C-n>
/ Down
```

Open command-line window with search history
```
:/
```

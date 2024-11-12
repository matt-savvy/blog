%{
  title: "Vim Buffers, Windows, and Tabs | Multi-file Workflows",
  author: "Matt",
  tags: ~w(vim cheat-sheets video),
  description: "Finally, windows you will want to use. See how I juggle buffers, work with windows, and how not to use tabs. "
}
---
<iframe
    class="embedded-yt"
    src="https://www.youtube.com/embed/XRIhRhDj3_c?rel=0"
    title="YouTube video player"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    referrerpolicy="strict-origin-when-cross-origin"
    allowfullscreen
>
</iframe>

## Cheat Sheet

[Windows Neovim Docs](https://neovim.io/doc/user/windows.html#_1.-introduction)

### Buffers

Show all buffers
```
:ls
```

Switch to buffer `3`
```
:b 3
```

Switch to buffer that has `some_file` in the filename.
```
:b some_file filename> <C-R>
:b some_file filename> <Tab>
```

Delete buffer number `3`
```
:bd 3
```

Go to next or previous buffer.
```
:bnext
:bprev
```

Open the altfile (last edited file)
```
:e #
```

My mappings for `bnext` and `bprev`, and the altfile
```lua
-- lua
vim.keymap.set("n", "]b", vim.cmd.bnext, { noremap = true, silent = true })
vim.keymap.set("n", "[b", vim.cmd.bprev, { noremap = true, silent = true })
vim.keymap.set('n', '[a', ':e #<CR>', { noremap = true, silent = true })
```
```vimscript
" vimscript
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [b :bprev<CR>
nnoremap <silent> [a :e #<CR>
```

Delete all buffers
```
:%bd
```

My function and keymap to clear all hidden buffers
```lua
local function clear_hidden_buffers()
    for _, buffer in pairs(vim.fn.getbufinfo()) do
        if buffer.hidden == 1 then
            vim.cmd.bd(buffer.bufnr)
        end
    end
end

vim.keymap.set('n', '<Leader>bd', clear_hidden_buffers, { silent = false, noremap = true })
```


### Windows

Open a new vertical window
```
<C-w>v
```


Open a new horizontal window (`s` for split)
```
<C-w>s
```

Cycle between windows in order
```
<C-w>w
```

Navigate windows
```
<C-w>h
<C-w>j
<C-w>k
<C-w>l
```

Try to resize windows to take up equal space
```
<C-w>=
```

Close current window
```
<C-w>c
```

Close all windows except the current (`o` for only this window)
```
<C-w>o
```

Change working directory of current window to `../other_project`
```
:lcd ../other_project
```

### Tabs

Open a new tab
```
:tabe
```

Open README.md in a new tab
```
:tabe README.md
```

Cycle between tabs
```
gt
```

Change working directory of current tab to `../other_project`
```
:tcd ../other_project
```

Close current tab
```
:tabc
```

Close all tabs except the current (`o` for only this tab)
```
:tabo
```

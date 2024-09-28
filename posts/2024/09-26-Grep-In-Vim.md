%{
  title: "Grep In Vim | Setup from Scratch (Video and Cheat Sheet)",
  author: "Matt",
  tags: ~w(vim cheat-sheets),
  description: "Grep from the ground up. We go from a stock install to dialed-in. "
}
---
<iframe
    class="embedded-yt"
    src="https://www.youtube.com/embed/q-dOcaI87E0?rel=0"
    title="YouTube video player"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    referrerpolicy="strict-origin-when-cross-origin"
    allowfullscreen
>
</iframe>

## Cheat Sheet

[`:grep` docs](https://neovim.io/doc/user/quickfix.html#%3Agrep) or `:h :grep`

The config shown here will not work as-is if using Neovim and ripgrep is available.
See [ripgrep](#With-Ripgrep)

Grep for the string `"Cat"` in the current working dir (recursively)
```
:grep Cat -R .
```

Open the quickfix list
```
:copen
```
Manually cycle through entries in the quickfix list
```
:cnext
:cprev
```

- [`grepprg` docs](https://neovim.io/doc/user/options.html#'grepprg') or `:h grepprg`
- [`grepformat` docs](https://neovim.io/doc/user/options.html#'grepformat') or `:h grepformat`

Configure `grepprg` to search in current working dir (recursively)
```lua
-- lua
vim.opt.grepprg = "grep -HRIn $* ."
```

### Keymaps
```lua
-- lua
-- use <Leader>gg to open quickfix list and Grep for a query
vim.keymap.set("n", "<Leader>gg", ":copen | :silent :grep ")

-- use ]q and [q to cycle through quickfix list
vim.keymap.set('n', ']q', ":cnext<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '[q', ":cprev<CR>", { noremap = true, silent = true })
```

Execute the `d` command to all hits in the quickfix list
```
:cdo d
```

Execute the `%s/Cat/Dog/g` command to all files in the quickfix list.
```
:cfdo %s/Cat/Dog/g
```

### With Ripgrep <a id="with-ripgrep"></a>

If ripgrep is available, Neovim will automatically configure `grepprg` and `grepformat` for use with ripgrep.

```lua
-- lua
vim.opt.grepprg="rg --vimgrep -uu"
vim.opt.grepformat="%f:%l:%c:%m"
```

```vimscript
"" vimscript
set grepprg=rg\ --vimgrep\ -uu
set grepformat=%f:%l:%c:%m
```

### Vim-Grepper

[mhinz/vim-grepper](https://github.com/mhinz/vim-grepper)

```lua
-- Keymap to open :Grepper
vim.keymap.set("n", "<Leader>gg", function() vim.cmd("Grepper") end, { silent = true })

-- configure to use ripgrep and git grep
vim.g.grepper = {
    tools = {"rg", "git"}
}
-- Use gs to take any motion and populate the search prompt
vim.keymap.set({"n", "x"}, "gs", "<plug>(GrepperOperator)")
```

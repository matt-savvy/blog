%{
  title: "Vim Registers Video Cheet Sheet",
  author: "Matt",
  tags: ~w(vim cheat-sheets),
  description: "Vim Registers / Video Cheet Sheet"
}
---

## Vim Registers
TLDR; A register is a place where vim will yank/delete/put text to and from.

[Registers Neovim docs](https://neovim.io/doc/user/change.html#registers) or `:h registers`

## Cheat Sheet

### Display Contents
Display content of all registers
```
:reg
```

Display content of just register `a`
```
:reg a
```

Display content of registers `a`, `b`, `c`, `1`, `2`, and `3`
```
:reg abc123"
```

### Working With Specific Registers

Use `"<register name><operation>`.
Registers are named `a` to `z` (lowercase only).

Yank selected text to register `z` (visual mode)
```
"zy
```
Yank a word to register `a` (with a motion)
```
"ayaw
```
Change from cursor to end of line, sending the text being changed to register `b`
```
"bC<new text here>
```
Delete a line, sending contents to register `c`.
```
"cdd
```

Use the uppercase register name to append to the text in the register.
Delete a word, appending it to the text in register `c`.
```
"Cdaw
```

Paste from register `a`
```
"ap
```

In insert mode, paste from register `b` without leaving insert mode.
```
<C-R>b
```

Unnamed register contains the text of your last yank, change, deletion.
In insert mode, paste from unnamed register (`"`) without leaving insert mode.
```
<C-R>"
```

Numbered registers `1` to `9` contains the text of your last line-wise yank, change, deletions.
Register `1` contains the most recent line(s), `2` the next most recent, `3` the next most recent before that, etc.

Paste from register `1`
```
"`p
```

Paste filename
```
"%p
```

Paste last search
```
"/p
```

Paste last command mode command
```
":p
```

Insert result of evaluating the expression `123+456` (while in insert mode)
```
<C-R>=
123+456
```

Insert result of evaluating the expression `1024/magic_number` (while in insert mode)
```
:let g:magic_number = 8
...
<C-R>=
1024/magic_number
```

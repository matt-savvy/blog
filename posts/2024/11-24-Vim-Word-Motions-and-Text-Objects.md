%{
  title: " Higher Level Editing with Vim Text Objects",
  author: "Matt",
  tags: ~w(vim cheat-sheet worksheet video),
  description: "This is really one of those keys to unlocking \"editing at the speed of thought\"."
}
---

<iframe
    class="embedded-yt"
    src="https://www.youtube.com/embed/Tk_vqJA4gK4?rel=0"
    title="YouTube video player"
    frameborder="0"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    referrerpolicy="strict-origin-when-cross-origin"
    allowfullscreen
>
</iframe>

## Try it Yourself!

```bash
curl https://blog.1-800-rad-dude.com/assets/vim-word-motions-and-text-objects-worksheet.txt | vim
```

or

[download this worksheet](/assets/vim-word-motions-and-text-objects-worksheet.txt)

## Cheat Sheet

[text object selection docs](https://neovim.io/doc/user/motion.html#_6.-text-object-selection) or `:h text-objects`

- Use `<operator>i<text object motion>` to operate on the inner boundary of the text object.
- Use `<operator>a<text object motion>` to operate on the entire text object.

<div class="cheat-sheet-table">

| operator-command-motion | result |
| ---                     | --- |
| `yiw` | yank inner boundary of word
| `yaw` | yank word and surrounding space
| `daw` | delete a word and its surrounding space
| `daW` | delete a Word (will include punctuation) and its surrounding space
| `vis` | visually select inside a sentence
| `vas` | visually select a sentence
| `dip` | delete contents of a paragraph
| `dap` | delete a paragraph and following linebreak
| `ci"` | change inside a pair of double quotes
| `ca"` | change a pair of double quotes
| `ci'` | change inside a pair of single quotes
| `ca'` | change a pair of single quotes
| ``ci` `` | change inside a pair of backticks
| ``ca` `` | change a pair of backticks
| `vib` | visually select inside a pair of parens
| `vi(` | visually select inside a pair of parens
| `vi[` | visually select inside a pair of square brackets
| `vi{` | visually select inside a pair of curly braces
| `vi<` | visually select inside a pair of angle brackets
| `cit` | change contents of an opening and closing tag
| `cat` | change an opening and closing tag and its contents

</div>

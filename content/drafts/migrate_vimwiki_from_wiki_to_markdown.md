Title: Migrate From Vimwiki To Markdown Syntax
Date: 2023-05-31
Category: Computer
Slug: migrate_from_vimwiki_to_markdown_syntax
Author: John Nduli

<!-- TODO: add tldr section linking to gist -->

I'd outgrown vimwiki's syntax since:

- I didn't use the syntax anywhere else except with vimwiki.
- There weren't a lot of tools to convert my wiki to html except
  `VimwikiAll2HTML`.

Using `markdown` solved all the above problems, and vimwiki supported it.

## Fixing My Config

I used the default vimwiki options e.g. path to vimwiki, so I didn't realize
that I'd set it up incorrectly. The options need to be set before vimwiki loads,
and here's the new config using [lazy](https://github.com/folke/lazy.nvim).

[ref](https://github.com/vimwiki/vimwiki/issues/935#issuecomment-661647681) 

```lua
{ 'vimwiki/vimwiki',
  branch = 'dev',
  dependencies = {'mattn/calendar-vim'},
  init = function()
    vim.g.vimwiki_list = {
      {path = "~/vimwiki", path_html= "~/vimwiki/public_html", auto_tags = 1, auto_diary_index = 1, syntax = 'markdown', ext = '.md'},
      -- experimental folder for markdown conversion
      {path = "~/projects/vimwiki", path_html= "~/projects/vimwiki_markdown/public_html", syntax = 'markdown', ext = '.md'}, }
    vim.g.vimwiki_markdown_link_ext = 1
    vim.g.vimwiki_stripsym = ' '
    vim.g.vimwiki_global_ext = 0
  end
},
```

## Pandoc Conversion

I used pandoc generation. For example, with the file:

```vimwiki
== Title ==

- [o] list item i:
  - [.] sublist
    - [X] sub sub
    - [ ] sub usb
    - [ ] sub sub1
  - [X] final

TODO: task 1

%% a comment I've left to address later

I'm a normal paragraph.

[[link to file]]

{{{bash
  ls -lah
  find . -iname '*.wiki'
}}}

Another code block

{{{
  ls -lah
  find . -iname '*.wiki'
}}}
```

and running `pandoc --from vimwiki --to commonmark_x trial.wiki` gave me:

````shell
╰─$ pandoc --from vimwiki --to commonmark_x trial.wiki
## Title {#Title}

- []{.done2}list item i:
  - []{.done1}sublist
    - []{.done4}sub sub
    - []{.done0}sub usb
    - []{.done0}sub sub1
  - []{.done4}final

[TODO:]{.todo} task 1

I\'m a normal paragraph.

[link to file](link to file "wikilink")

``` bash
  ls -lah
  find . -iname '*.wiki'
```

Another code block

      ls -lah
      find . -iname '*.wiki'
````

The conversion wasn't perfect because:

- it added an extra indentifer to the header
- the checklist items wouldn't work with vimwiki plugin
- the TODO comment became a link (TODO: confirm terminology)
- they escaped the `'` character
- The link to the file contained a "wikilink" text and wouldn't work in vimwiki
- I lost my comment
- The last code block wasn't wrapped around \` characters

This was a great starting point though and I'd use sed to modify the conversion.

## Preprocessing
To prevent the comment from getting lost in translation, I modified all lines
with comments by prefixing them with `TODO: comment`.

I wanted the eventual wiki code blocks to be wrapped in \`. I converted all code
blocks without a language i.e. `{{{` to have bash i.e. `{{{bash` and I'd change
the language later on:

```shell
sed -r -e 's/\{\{\{$/\{\{\{bash/g' -e 's/%%/TODO: comment/g' trial.wiki
```

For example

```shell
╰─$ echo -e "%% save me\nNormal line %% with ending\n{{{" | sed -r -e 's/\{\{\{$/\{\{\{bash/g' -e 's/%%/TODO: comment/g'                                              1 ↵

TODO: comment save me
Normal line TODO: comment with ending
{{{bash
```

## Post processing

To fix the links, I changed all vimwiki links e.g. `[link to file](link to file
"wikilink")` to a format that would still work with vimwiki's markdown support
i.e. `[link to file](link to file.md)`. 

I also converted all checklists to github's checklist syntax with:

```shell
    -e "s/\[\]\{\.done[0-3]\}/\[ \] /g" \
    -e "s/\[\]\{\.done4\}/\[X\] /g" \
```

and also unquoted all `'` characters with:

```shell
    -e "s/\\\'/\'/g" \
```

Here's the final post processing step:

```shell
  sed -r -i -e 's/(\[.*\])\(([^#]*)((.*) "wikilink")\)/\1\(\2.md\4\)/g' \
    -e "s/\\\'/\'/g" \
    -e "s/\[\]\{\.done[0-3]\}/\[ \] /g" \
    -e "s/\[\]\{\.done4\}/\[X\] /g" \
    "$md_file"
```

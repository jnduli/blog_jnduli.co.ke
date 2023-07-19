Title: Migrate From Vimwiki To Markdown Syntax
Date: 2023-07-29
Category: Computer
Slug: migrate_from_vimwiki_to_markdown_syntax
Author: John Nduli

[Vimwiki](https://github.com/vimwiki/vimwiki) supports markdown and I switched
to this because:

- I didn't use the default syntax anywhere else.
- I could convert to html using only `VimwikiAll2HTML`.

## Fixing My Config

Vimwiki expects some options set before it loads
([ref](https://github.com/vimwiki/vimwiki/issues/935#issuecomment-661647681)).
With [lazy](https://github.com/folke/lazy.nvim), I use `init` like:


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

I tested [pandoc](https://pandoc.org/) for conversion with the file:

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

Running `pandoc --from vimwiki --to commonmark_x trial.wiki` gave me:

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

I had these problems with the conversion:

- the checklist generated wouldn't work with vimwiki
- I didn't want the escaped `'`  character in my files
- The link to a file had the string "wikilink" which wouldn't work in vimwiki
- I lost my comment
- The last code block wasn't wrapped around \` characters

I'd combine `sed` with `pandoc` to get what I wanted.

## Preprocessing

I replaced the comment identifier `%%` with `TODO: comment` to the prevent
losing them during conversion. I also replaced code blocks without a language
i.e. `{{{` to have bash i.e. `{{{bash` and I'd replace this when editting later.

```shell
╰─$ echo -e "%% save me\nNormal line %% with ending\n{{{" \
      | sed -r -e 's/\{\{\{$/\{\{\{bash/g' \
               -e 's/%%/TODO: comment/g'
TODO: comment save me
Normal line TODO: comment with ending
{{{bash
```

## Post processing

I changed the vimwikie-converted linked i.e. `[link_to_file](link_to_file
"wikilink")` to use the file name i.e. `[link_to_file](link_to_file.md)`.

``` shell
echo -e "[link_to_file](link_to_file \"wikilink\")" \
  | sed -r -e 's/(\[.*\])\(([^#]*)((.*) "wikilink")\)/\1\(\2.md\4\)/g'
```

I converted all checklists to github's checklist syntax with:

```shell
echo -e "- []{.done4}done\n- []{.done0} not_done" \
  | sed -r -e "s/\[\]\{\.done[0-3]\}/\[ \] /g" \
           -e "s/\[\]\{\.done4\}/\[X\] /g"
```

and also unquoted all `'` characters with:

```shell
echo -e "\\'" | sed -e "s/\\\'/\'/g"
```

Here's the final post processing step:

```shell
  sed -r -i -e 's/(\[.*\])\(([^#]*)((.*) "wikilink")\)/\1\(\2.md\4\)/g' \
    -e "s/\\\'/\'/g" \
    -e "s/\[\]\{\.done[0-3]\}/\[ \] /g" \
    -e "s/\[\]\{\.done4\}/\[X\] /g" \
    "$md_file"
```

## Putting It All Together

```bash

#!/bin/bash

set -euo pipefail

# files to change extension from to md format
readarray -d '' mv_files < <( \
  find . \( -iwholename '*diary/*.wiki' \
    -or -iwholename '*unorganized_things/*.wiki' \
    -or -iwholename '*design_docs/*.wiki' \
    -and -not -iname 'diary.wiki' \
    -and -not -iname 'index.wiki' \) \
    -print0 
)

for file in "${mv_files[@]}"; do
  md_file="${file%%.wiki}.md"
  mv "$file" "$md_file"
done

readarray -d '' files < <(find . -name "*.wiki" -print0)
for file in "${files[@]}"; do
  md_file="${file%%.wiki}.md"
  sed -r -e 's/\{\{\{$/\{\{\{bash/g' -e 's/%%/TODO: comment/g' "$file" | pandoc --from vimwiki --to commonmark_x -o "$md_file"
  sed -r -i -e 's/(\[.*\])\(([^#]*)((.*) "wikilink")\)/\1\(\2.md\4\)/g' \
    -e "s/\\\'/\'/g" \
    -e "s/\[\]\{\.done[0-3]\}/\[ \] /g" \
    -e "s/\[\]\{\.done4\}/\[X\] /g" \
    "$md_file"
  rm "$file"
done
```

Title: SC-IM Color Configuration
Date: 2023-07-01
Category: Computer
Slug: sc-im-color-configuration
Author: John Nduli

I couldn't read cells in [sc-im](https://github.com/andmarti1424/sc-im) because
there was little contrast between the background and foreground colors. I
temporarily fixed this by changing my terminal's color scheme, but I'd prefer to
keep it. A permanent solution was to change sc-im's colors, for example:

```vim
color "type=INPUT fg=WHITE bg=BLACK"
```

and changed the colors of the help documentation with:

```bash
color "type=NORMAL fg=WHITE bg=BLACK"
```

The help menu provides more details for the colors to use. You type `:help` and
search for color with `\color`, getting the explanations for all the types
supported. I experimented with a couple of options and saved my final colors in
`~/.scimrc`. Here's what I had:

```bash
color "type=INPUT fg=WHITE bg=DEFAULT_COLOR"
color "type=NORMAL fg=WHITE bg=DEFAULT_COLOR"
color "type=ERROR_MSG fg=RED bg=BLACK"
color "type=CELL_SELECTION fg=BLACK bg=WHITE"
color "type=HEADINGS fg=WHITE bg=DEFAULT_COLOR"
color "type=WELCOME fg=WHITE bg=DEFAULT_COLOR"
color "type=MODE fg=WHITE bg=DEFAULT_COLOR"
```

I also found a ticket on the problem and presented my solution
[here](https://github.com/andmarti1424/sc-im/issues/297#issuecomment-449555863).

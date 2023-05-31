Title: SC-IM Color Configuration
Date: 2023-05-27
Category: Computer
Slug: sc-im-color-configuration
Author: John Nduli

The color scheme I had didn't work well with
[sc-im](https://github.com/andmarti1424/sc-im). I looked into a custom color
configuration to increase the contrast, keeping it simple with WHITE and BLACK.

To change command input colors:

```vim
color "type=INPUT fg=WHITE bg=BLACK"
```

To change the colors of the help documentation:

```bash
color "type=NORMAL fg=WHITE bg=BLACK"
```

The help menu provides more details for the colors to use. You type `:help` and
search for color with `\color`. It provides the different values for type and an
explanation for each.

I ended up saving this configuration in `~/.scimrc`:

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

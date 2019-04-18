#########################
SC-IM Color Configuration
#########################

:date: 2019-03-04 15:00
:tags: linux 
:category: Computer
:slug: sc-im-color-configuration
:author: John Nduli
:status: draft


SC-IM looks really bad by default on my laptop. I'm using xfce4-terminal
with solarized-light color scheme. To fix this, you need to test out
various color.

For the commands you input to be visible use this:

color "type=INPUT fg=WHITE bg=BLACK"

When I type :help, I cant also see the test in there. To fix that, type
this command>

color "type=NORMAL fg=WHITE bg=BLACK"

From the help menu, search for color and you'll get this:

HEADINGS, MODE, NUMB, STRG, DATEF, EXPRESSION,
 CELL_ERROR, CELL_NEGATIVE, CELL_SELECTION,
 CELL_SELECTION_SC, INFO_MSG, ERROR_MSG, CELL_ID,
 CELL_FORMAT, CELL_CONTENT, WELCOME, NORMAL, INPUT.

CELL SELECTION : refers to the header and row title e.g. if on cell C1,
this refers to the header C and header 1.

CELL_SELECTION_SC: refers to the colors of the selected cell.
You can play with these and see which works best for you.

ERROR_MSG: is what is displayed when an error is encountered. To check
this, just type :csd to see an error.

HEADINGS: refers to header names that are not active.

For the cell information use this:


For the colors:

 WHITE, BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN or DEFAULT_COLOR.
                     DEFAULT_COLOR just takes the default color of your
                     terminal. If you set it as fg color it will take default
                     color of your foreground. If you set it as bg color it
                     will take the default background color of your terminal.


Once done testing, you can save the color configurations in `~/.scimrc`
for permanent settings. 

Heres is one I'm using:


color "type=INPUT fg=WHITE bg=DEFAULT_COLOR"
color "type=NORMAL fg=WHITE bg=DEFAULT_COLOR"
color "type=ERROR_MSG fg=RED bg=BLACK"
color "type=CELL_SELECTION fg=BLACK bg=WHITE"
color "type=HEADINGS fg=WHITE bg=DEFAULT_COLOR"
color "type=WELCOME fg=WHITE bg=DEFAULT_COLOR"
color "type=MODE fg=WHITE bg=DEFAULT_COLOR"



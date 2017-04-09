Title: Changing Menu Icon MinCss
Date: 2017-02-12 08:55
Category: Computer
Tags: mincss, css
Author: John Nduli
status: published

I wanted to make this pelican theme that is really light weight. I
did some research and came upon mincss. Now this is a really small
CSS framework that supports a wide range of browsers. For more
info, check out [here](https://github.com/owenversteeg/min/tree/gh-pages/compiled)

I encountered a small problem however. I wanted to change my menu
background colour. By default, micsss menu has a black backgroun
and a menu icon that is white in colour.

So I thought they used an icon or image, only to find out mincss
has this really neat treat of using borders. The following line
shows its implementation:

    ::css
    .nav div:before {
        background: #000;
        border-bottom: 10px double;
        border-top: 3px solid;
        content: '';
        float: right;
        height: 4px;
        position: relative;
        right: 3px;
        top: 14px;
        width: 20px;
    }

This code creates three lines with the border command thus the
menu icon.

To make it appear well in my theme, ie. in a white background with
black lines, I just changed the code to this.

    ::css
    .nav div:before {
        background: #fff;
        <!--everything else remains the same-->
    }

I then added a bit of snippets on my own to make the background
white.

    ::css
    .nav{
        background: #ffffff;
    }

And thus I had a menu I pretty much liked.

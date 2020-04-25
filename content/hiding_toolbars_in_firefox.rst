##########################
Hiding Toolbars in Firefox
##########################
:date: 2020-04-18
:category: Linux
:tags: linux, projects
:slug: hiding-toolbars-in-firefox
:author: John Nduli
:status: published


While using i3, I've realized that a lot of screen real estate in
firefox is taken up with the tab and navigation bar. This isn't a
problem when its the only application open, but when some tiling has
been done, these two bars quickly become a barrier to usage, for
example:

.. image:: {static}/images/firefox_with_tabs.png
    :alt: firefox with tabs

Because of this, I decided to hide these two bars. However, this could
not be done by either firefox options or plugins. I therefore had to
enable `toolkit.legacyUserProfileCustomizations.stylesheets` by visiting
`about:config` in the browser, searching for this, and setting it to
true. This would enable customization using a `userChrome.css` template.

I then visited `about:profile`, noted the Root Directory for my primary
profile and created a `chrome` folder in that directory. I then added
the `userChrome.css` file in there with the contents:

.. code-block:: js

    @namespace url("http://www.mozilla.org/keymaster/gatekeeper/there.is.only.xul");
    /*
     * Reference: https://www.reddit.com/r/FirefoxCSS/comments/boetx7/annoying_page_jump_with_address_bar_autohide/engne27/
     */
    /* Hide Tabbar until mouse is around it */

    #TabsToolbar:not([customizing="true"]):not([inFullscreen]){
        height: 1px !important;
        transition: all 50ms ease 0s !important;
    }
    #TabsToolbar:hover:not([inFullscreen]), 
    #TabsToolbar:focus-within{
        height: auto !important; /* 29px compact, 33px normal, YMMV */
        transition: all 50ms ease 0s !important;
    }

    /* Hide nav-bar until mouse hovers */
    #nav-bar:not([customizing="true"]):not([inFullscreen]){
        height: 1px !important;
        min-height: 1px !important;
        transition: all 5s ease 0s !important;
        overflow: hidden;
        z-index: -5 !important;
    }
    #nav-bar:hover, #navigator-toolbox:hover:not([inFullscreen]) > #nav-bar,
    #navigator-toolbox:focus-within > #nav-bar{
        height: auto !important;
        transition: all 50ms ease 0s !important;
        z-index: 5 !important;
    }

The image below shows the result of this:

.. image:: {static}/images/firefox_hidden_tabs.png
    :alt: firefox with hidden tabs and navbar

For firefox 75 I had to disable this `browser.urlbar.update1` for the
urlbar to stop behaving weirdly.

References:

#. https://www.userchrome.org/help-with-userchrome-css.html
#. https://github.com/Timvde/UserChrome-Tweaks/blob/master/toolbars/auto-hide.css
#. https://support.mozilla.org/en-US/questions/1185760

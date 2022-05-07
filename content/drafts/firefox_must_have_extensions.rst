########################
My Firefox Configuration
########################

:date: 2022-05-06
:category: Computer
:slug: my_firefox_configuration
:author: John Nduli
:status: draft

I like using firefox, and I've set it up to be ideal for my workflow. Here are
the extensions I have:

+ `Dark reader <https://addons.mozilla.org/en-US/firefox/addon/darkreader/>`_: I
  prefer having a dark background with light text, so this helps me out with it.
  The only caveat I have is my bank website doesn't work with this, so I've had
  to exclude it from the websites the plugin can work with.
+ `Tab Counter
  <https://addons.mozilla.org/en-US/firefox/addon/tab-counter-webext/>`_:
  Provides information on how many windows I have open, how many tabs are open,
  and the tabs in the current window. This helps me have a rough idea of whether
  my tabs are becoming unmanageable.
+ `Tridactyl <https://addons.mozilla.org/en-US/firefox/addon/tridactyl-vim/>`_:
  provides vim keybindings from firefox. I love its ease of use especially the
  bookmarking feature. Some extra configurations I've done for this is change
  the default theme to shydactyl-dark using:

    .. code-block:: lua

      colors --url https://raw.githubusercontent.com/eeshugerman/shydactyl-variations/master/dist/shydactyl-dark.css shydactyl-dark
      colourscheme shydactyl-dark


  An issue I had was when opening a new tab, I'd get a temporary white light
  that would immediately switch to dark mode. It was like a flash bang, and it
  was really irritating. To deal with this, `see this github comment
  <https://github.com/tridactyl/tridactyl/issues/2510#issuecomment-763198138I>`_.
  I added the following to `$HOME/.mozilla/firefox/profile-dir/chrome/userContent.css`:
  
    .. code-block:: lua

        /* 
           dark background in new tabs without a white flash (with tridactyl newtab)
           @see: https://github.com/tridactyl/tridactyl/issues/2510
        */
        :root {
          --tridactyl-bg: #1d1b19 !important;
          --tridactyl-fg: white !important;
        }

        /*
            set the background color of the new tab page (without tridactyl or with tridactyl without newtab)
        */
        @-moz-document url-prefix(about:home), url-prefix(about:newtab) {
          body {
            background: #1d1b19;
          }
        }

+ `uBlock origin
  <https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/>`_
+ `Leechblock NG
  <https://addons.mozilla.org/en-US/firefox/addon/leechblock-ng/>`_: This
  provides a way to block sites that are blocking my time. It makes is difficult
  to do some time wasting things like watching youtube, hence I'll avoid them.
+ `Remove youtube suggestions
  <https://addons.mozilla.org/en-US/firefox/addon/remove-youtube-s-suggestions/>`_:
  Addon that helps block distracting features from youtube. I've removed the
  `Explore link`, `Shorts link` and `End of Video suggestions`.


.. TODO: clean up the sections below

+ SponsorBlock for YouTube - Skip Sponsor
+ Firefox Mult-Account Containers

.. TODO: add list of configs

I also change the following configs:

.. code-block:: lua

    dom.event.clipboardevents.enabled = False
    layout.css.devPixelsPerPx = 1.25
    ui.systemUsesDarkTheme = true
    toolkit.legacyUserProfileCustomizations.stylesheets = true
    browser.display.background_color = #000000
    browser.display.foreground_color = #ffffff


########################
My Firefox Configuration
########################

:date: 2022-05-06
:category: Computer
:slug: my_firefox_configuration
:author: John Nduli
:status: draft

I like firefox, and I've tweaked it to be ideal for my workflow. Here are
the extensions I have:

+ `Dark reader <https://addons.mozilla.org/en-US/firefox/addon/darkreader/>`_: I
  prefer having a dark background with light text, so this applies a dark theme
  to websites to. The only problem is my bank website doesn't work with this, so
  I've had to exclude it from the websites the plugin can work with.
+ `Tridactyl <https://addons.mozilla.org/en-US/firefox/addon/tridactyl-vim/>`_:
  provides vim keybindings to firefox. Its intuitive to use, and I'm especially
  fond of its bookmarking feature. I've changed the theme to shydactyl-dark using:

    .. code-block:: lua

      colors --url https://raw.githubusercontent.com/eeshugerman/shydactyl-variations/master/dist/shydactyl-dark.css shydactyl-dark
      colourscheme shydactyl-dark

  I had an issue when opening a new tab, where I'd see a white light that would
  immediately switch to dark mode, a flash bang, and it disoriented me for a
  while. `This github comment
  <https://github.com/tridactyl/tridactyl/issues/2510#issuecomment-763198138I>`_
  provides the solution. I added the following to
  `$HOME/.mozilla/firefox/profile-dir/chrome/userContent.css`:
  
    .. code-block:: css 

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
  <https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/>`_: an ad
  blocker
+ `Leechblock NG
  <https://addons.mozilla.org/en-US/firefox/addon/leechblock-ng/>`_: Blocks
  sites that waste my time. It makes is difficult to open distracting websites
  like youtube, hence it's almost impossible to visit them.
+ `Remove youtube suggestions
  <https://addons.mozilla.org/en-US/firefox/addon/remove-youtube-s-suggestions/>`_:
  Addon that helps block distracting features from youtube. I've removed the
  `Explore link`, `Shorts link` and `End of Video suggestions`.
+ `Tab Counter
  <https://addons.mozilla.org/en-US/firefox/addon/tab-counter-webext/>`_:
  Provides information on how many windows I have open, how many tabs are open,
  and the tabs in the current window. This gives me a rough idea of whether my
  tabs are becoming unmanageable.
+ `SponsorBlock
  <https://addons.mozilla.org/en-US/firefox/addon/sponsorblock/>`_: helps to
  skip sponsor sections in youtube videos.


.. TODO: take a note of this and try to replicate it and apply the fix

https://wiki.archlinux.org/title/Firefox#Right_mouse_button_instantly_clicks_the_first_option_in_window_managers

.. TODO: add list of configs

I also change the following configs:

.. code-block:: lua

    dom.event.clipboardevents.enabled = False
    layout.css.devPixelsPerPx = 1.25
    ui.systemUsesDarkTheme = true
    toolkit.legacyUserProfileCustomizations.stylesheets = true
    browser.display.background_color = #000000
    browser.display.foreground_color = #ffffff


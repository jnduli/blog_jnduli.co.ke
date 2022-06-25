########################
My Firefox Configuration
########################

:date: 2022-05-06
:category: Computer
:slug: my_firefox_configuration
:author: John Nduli
:status: draft

I like firefox, and I've tweaked it to be ideal for me. The extensions I have
are:

+ `Dark reader <https://addons.mozilla.org/en-US/firefox/addon/darkreader/>`_: I
  prefer dark themes, so this applies one to websites. This works great except
  for my bank's website, which I've excluded in the plugin.
+ `Tridactyl <https://addons.mozilla.org/en-US/firefox/addon/tridactyl-vim/>`_:
  provides vim keybindings. It's intuitive and I'm fond of how it implemented
  bookmarks. I changed the theme to shydactyl-dark using:

    .. code-block:: lua

      colors --url https://raw.githubusercontent.com/eeshugerman/shydactyl-variations/master/dist/shydactyl-dark.css shydactyl-dark
      colourscheme shydactyl-dark

  When opening a new tab, there'd be a white canvas that immediately
  switched to dark-mode, a flash bang, which was disorienting. I found a solution on `this github comment
  <https://github.com/tridactyl/tridactyl/issues/2510#issuecomment-763198138I>`_
  and applied it by opening `$HOME/.mozilla/firefox/profile-dir/chrome/userContent.css` and adding:
  
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
  <https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/>`_: ad blocker
+ `Leechblock NG
  <https://addons.mozilla.org/en-US/firefox/addon/leechblock-ng/>`_: blocks
  sites that I don't want to visit. I have to add these sites to a block list though,
  but once done, it's difficult to open them. I've added youtube, twitter and
  more, and this helps me concentrate on important tasks.
+ `Remove youtube suggestions
  <https://addons.mozilla.org/en-US/firefox/addon/remove-youtube-s-suggestions/>`_:
  blocks distracting features on youtube. I've removed the `Explore link`,
  `Shorts link` and `End of Video suggestions`.
+ `Tab Counter
  <https://addons.mozilla.org/en-US/firefox/addon/tab-counter-webext/>`_: shows
  how many windows and tabs I have open, and the number of tabs in the current
  window. This gives me a rough idea of whether my tabs are becoming
  unmanageable.
+ `SponsorBlock
  <https://addons.mozilla.org/en-US/firefox/addon/sponsorblock/>`_: skips
  sponsor sections in youtube videos.

I also change the following configs:

.. code-block:: lua

    dom.event.clipboardevents.enabled = False
    layout.css.devPixelsPerPx = 1.25
    ui.systemUsesDarkTheme = true
    toolkit.legacyUserProfileCustomizations.stylesheets = true
    browser.display.background_color = #000000
    browser.display.foreground_color = #ffffff


I also sometimes got a problem where the first option on right click would be
clicked automatically in firefox. I haven't got this in a while, but here's a
solution just in case: `soln for mouse clicking
<https://wiki.archlinux.org/title/Firefox#Right_mouse_button_instantly_clicks_the_first_option_in_window_managers>`_

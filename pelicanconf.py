#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals
import os

AUTHOR = 'John Nduli'
SITENAME = "Nduli's World"
SITEURL = ''

PATH = 'content'

TIMEZONE = 'Africa/Nairobi'

DEFAULT_LANG = 'en'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# Blogroll
LINKS = (('Pelican', 'http://getpelican.com/'),
         ('Python.org', 'http://python.org/'),
         ('Jinja2', 'http://jinja.pocoo.org/'),
         ('You can modify those links in your config file', '#'),)

# Social widget
SOCIAL = (('You can add links in your config file', '#'),
          ('Another social link', '#'),)

DEFAULT_PAGINATION = 10

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True

THEME = os.getenv('HOME') +'/documents/pelican_requirements/letter_theme'
#THEME ='/home/rookie/Documents/projects/tutorials/pelican_tut/pelican-themes/gum'

PLUGIN_PATHS = [os.getenv('HOME')+'/documents/pelican_requirements/pelican-plugins']
print(PLUGIN_PATHS)
PLUGINS = ['render_math']

#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = 'John Nduli'
SITENAME = "Nduli's World"
SITEURL = ''

PATH = 'content'

TIMEZONE = 'Africa/Nairobi'
DEFAULT_DATE_FORMAT = '%b %Y'

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

MENUITEMS = (('Comics', 'https://comics.jnduli.co.ke/'),)

# Social widget
SOCIAL = (('You can add links in your config file', '#'),
          ('Another social link', '#'),)

DEFAULT_PAGINATION = 10

DEFAULT_METADATA = {
    'status': 'draft',
}

PAGE_ORDER_BY = 'reversed-title'

# Uncomment following line if you want document-relative URLs when developing
# RELATIVE_URLS = True

THEME = './letter_theme'

PLUGIN_PATHS = ['./pelican-plugins']
PLUGINS = ['render_math']

STATIC_PATHS = [
    'static/favicon.ico',
    ]

EXTRA_PATH_METADATA = {
    'static/favicon.ico': {'path': 'favicon.ico'},
    }

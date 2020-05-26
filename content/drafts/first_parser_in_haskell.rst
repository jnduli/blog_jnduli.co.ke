############################################
First Haskell Parser (for Kindle Highlights)
############################################

:date: 2019-04-27 19:00
:tags: linux, product, review
:category: Computer
:slug: huion-420-driver-setup
:author: John Nduli
:status: draft


Kindle saves highlights, bookmarks and notes in a `My Clippings.txt`
file. I wanted a way to parse it and filter out the content I wanted.
I also wanted to work on a parser in haskell, so this was a great
opportunity to get my hands dirty.

I used stack to manage the project by running:

.. code-block:: bash

    stack new kindle-highlights simple
    cd kindle-highlights
    stack setup
    stack ghci # launches haskell repl for project

Within the `ghci repl`, the following commands were useful when making
changes:

.. code-block:: bash

    :load Main
    :r # reload changes made to code


`Parsec <https://hackage.haskell.org/package/parsec>`_ is the library I
chose to use. To start of, I wanted to parse a simple string that had a
similar structure to the kindle file:

.. code-block:: haskell

    exampleString = "this\nis\ngood\n==========\nanther\ngroup\n=========="

The `exampleString` above contains two different highlights each
separated with `==========`. To get a single group, I'd look for this
separator and collect the groups before this. To do this in parsec:

.. code-block:: haskell

    import Text.Parsec


    eogString :: String
    eogString = "=========="

    endOfGroup :: Parsec String st String
    endOfGroup = string eogString

    kindleGroup :: Parsec String st String
    kindleGroup = manyTill anyChar (try endOfGroup)

    test = parse kindleGroup "failed" exampleString

Running `test` in ghci returns `Right "this\nis\ngood\n"`.

`endOfGroup` is a parser that only matches the `eogString`. This is
combined with the `kindleGroup` to get all characters (using `anyChar`)
until the `endOfGroup` is found.

All the groups can be got by building on this through:

.. code-block:: haskell

    groups :: Parsec String st [String]
    groups = do
      first <- kindleGroup
      next  <- remainingGroups
      return (first : next)

    remainingGroups :: Parsec String st [String]
    remainingGroups = (char '\n' >> groups) <|> return []

    test = parse groups "fail" (exampleString)

which results in `Right ["this\nis\ngood\n","anther\ngroup\n"]`.
Groups gets a group from the string, and passes the rest of the string
to the remainingGroups function. This in turn checks if the first
character in the string is `\n` after which it calls groups on the
string.

The above gave me a good framework for working on the kindle highlighter
which has the general form:


.. code-block:: bash

    book title
    - Your Highlight on page 818-810 | Added on Wednestday, 24 October 2018 04:41:47

    the actual highlighted sections
    ==========
    book title
    - Your Highlight on page 818-810 | Added on Wednestday, 24 October 2018 04:41:47

    the actual highlighted sections
    ==========


This is what I came up with for that:

.. code-block:: haskell

    -- test
    test = parse highlight "fail" exampleGroup

    title :: Parsec String st String
    title = manyTill anyChar newline 

    location :: Parsec String st [String]
    location = between (string "- Your Highlight at location ") (oneOf " |") locationGroupings

    locationGroupings = do
        start <- many1 digit
        char '-'
        end <- many1 digit
        return [start, end]

    highlight :: Parsec String st [String]
    highlight = do
        t <- title
        l <- location
        title
        title
        h <- title
        let x = [t, h] ++ l
        return x

    exampleGroup = "Axiomatic (Greg Egan)\n" ++ 
        "- Your Highlight at location 3722-3722 | Added on Sunday, 28 October 2018 08:42:11\n" ++
        "\n" ++
        "mind; maybe some dreams take shape only in the\n"


This results in `Right ["Axiomatic (Greg Egan)","mind; maybe some dreams take shape only in the","3722","3722"]`

To parse multiple groups, we just:

.. code-block:: lua

    groups :: Parsec String st [[String]]
    groups = do
      first <- highlight
      next  <- remainingGroups
      return (first : next)

    remainingGroups :: Parsec String st [[String]]
    remainingGroups = (char '\n' >> groups) <|> return []

    test = parse groups "fail" (exampleGroup ++ "\n" ++ exampleGroup)

This returns: 

`Right [["Axiomatic (Greg Egan)","mind; maybe some dreams take shape only in the","3722","3722"],["Axiomatic (Greg Egan)","mind; maybe some dreams take shape only in the","3722","3722"]]`

The kindle format has more nuts than what the above demonstrates, but
nevertheless I had a lot of fun working with this.

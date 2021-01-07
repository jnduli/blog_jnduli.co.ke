#####################################
Setting up Hspec on a Haskell Project
#####################################

:date: 2021-01-07
:tags: projects
:category: Engineering
:slug: setting-up-hspec-on-haskell-project
:author: John Nduli
:status: draft


I'd started the Kindle-Highlights project without tests and needed to
add this as I'd been using the tool more and more often, and wanted to
be sure changes I was making did not break things. For haskell hspec is
the tool for this. Setting this up on the project was surprisingly
challenging, mostly due to failing to properly read the docs.

Some of the things I missed out on are:

- Test files should have the suffix Spec
- There is auto detection of test files
- I needed to set up some of my modules properly in the cabal file.
- Had to move executable to different directory to prevent warning on
  missing deps: see https://github.com/commercialhaskell/stack/issues/3109
- switched to cabal version 2.2 to use the shared properties field.


In summary, here are the steps I took to having a properly working and
tested code base:

Cabal Setup
-----------
Modifying the cabal configs to have a library section, with
exposed_modules for the code I want to test, and a testing section.

TODO: break down build-depends into common ones to prevent duplication

.. code-block:: haskell

    common shared-properties
      default-language:    Haskell2010
      build-depends:       base >= 4.7 && < 5,
                           parsec,
                           text,
                           containers,
                           time

    library
      import:              shared-properties
      exposed-modules:     KindleHighlights,
                           CommandOptions
      hs-source-dirs:      src
      build-depends:       optparse-applicative


    executable kindle-highlights
      import:              shared-properties
      hs-source-dirs:      app
      main-is:             Main.hs
      build-depends:       optparse-applicative,
                           kindle-highlights,


    test-suite spec
      import:              shared-properties
      type:                exitcode-stdio-1.0
      hs-source-dirs:      test
      main-is:             Spec.hs
      other-modules:       ParserSpec
      build-depends:       kindle-highlights,
                           hspec >= 2.7,
                           hspec-discover >= 2.7
      ghc-options: -Wall
      build-tool-depends: hspec-discover:hspec-discover == 2.*



Key things here are that the test-suite spec points to the 'test'
directory, with `hspec` and `hspec-discover` added as build-depends.

Writing the Tests
-----------------

To enable automatic test discovery, the `Spec.hs` file has:

.. code-block:: haskell

    {-# OPTIONS_GHC -F -pgmF hspec-discover #-}


which means it will automatically pick up tests that I write. Key to
note here is that the test files has to have the `Spec` suffix for this
to work.


To write a test file, for example, `ParserSpec.hs`

.. code-block:: haskell

    module ParserSpec
      ( spec
      )
    where


    spec :: Spec
    spec = describe "KindleHighlights" $ do
      it "has a string definition for end of group"
        $          eogString
        `shouldBe` "==========\r\n"


has to export the spec function, which will be called by hspec.

Running the tests with `stack test` should show:

.. code-block:: haskell
    .
    .
    .

    kindle-highlights> test (suite: spec)

    Progress 1/2: kindle-highlights
    Parser
      KindleHighlights
        has a string definition for end of group
        highlights
        highlights 2
        groups

    Finished in 0.0004 seconds
    4 examples, 0 failures

    kindle-highlights> Test suite spec passed
    Completed 2 action(s).




References:
https://cabal.readthedocs.io/en/latest/developing-packages.html#common-stanzas
https://hspec.github.io/writing-specs.html

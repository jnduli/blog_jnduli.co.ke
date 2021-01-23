#####################################
Setting up Hspec on a Haskell Project
#####################################

:date: 2021-01-23
:tags: projects
:category: Engineering
:slug: setting-up-hspec-on-haskell-project
:author: John Nduli
:status: published 


I'd started the `Kindle-Highlights project
<https://github.com/jnduli/kindle_highlights>`_ without tests. This was
a problem because I couldn't add features as fast as I wanted because
I'd break something without knowing. I needed to add tests to speed up
my development. For haskell, `hspec <https://hspec.github.io/>`_  is a
tool/library for this. Setting this up on the project was surprisingly
challenging, mostly because I didn't properly read the docs.

Some of the things I missed out on or had to do are:

- There is auto detection of test files with `hspec-discover
  <https://hspec.github.io/hspec-discover.html>`_.
- Test files should have the suffix Spec (I'd added them with a Test
  Suffix) to be auto discovered by hspec-discover.
- Each test file has to export a `spec` of type Spec
- I needed to set up some of my modules properly in the cabal file.
- I had to move executable to a different directory to prevent warning
  on missing dependencies, see `github stack issue `
  <https://github.com/commercialhaskell/stack/issues/3109>`_.
- I switched to cabal version 2.2 to use the shared properties field.

Here are the steps I took to having a properly working and tested code
base:

Cabal Setup
-----------
I modified my cabal config by:

- Using cabal version 2.2: this is so that I could use common stanzas
  preventing duplication of dependencies, see `cabal common-stanzas
  <https://cabal.readthedocs.io/en/latest/developing-packages.html#common-stanzas>`_
- Adding a library section that exposed the modules that I wanted to
  test.
- Adding a test section that contained hspec options. 
- Added an executable section and moved the executable code `Main.hs` to
  another folder to prevent warning errors on missing dependencies.


.. code-block:: cabal

    cabal-version:       2.2
    name:                kindle-highlights
    .
    .

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


which means it will automatically pick up tests that I write. The test
files has to have the `Spec` suffix for this to work.

To write a test file, for example, `ParserSpec.hs`

.. code-block:: haskell

    module ParserSpec (spec) where

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

which shows the tests ran successfully.

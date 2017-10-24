# XBeach documentation

[![CircleCI](https://circleci.com/gh/openearth/xbeach-docs.svg?style=svg)](https://circleci.com/gh/openearth/xbeach-docs)

This repository holds the latest built of the XBeach documentation.

The web version of the documentation can be found at: http://xbeach.readthedocs.io/

## Contribute

We adopted a continous integration workflow using forked pull requests for contributions to the XBeach documentation.
This means that you will need to ``fork`` the openearth/xbeach-docs repository to contribute:

1. At http://github.com/openearth/xbeach-docs, create a ``fork`` in a personal Github account (upper right corner).
2. Through your favorite Git client (e.g. [TortoiseGit](https://tortoisegit.org)), create a local ``clone`` of the personal ``fork`` (`http://github.com/<youraccount>/xbeach-docs`).

You can reuse the personal ``fork`` and local ``clone`` for any future contribitions.
To submit and review contributions to the XBeach documentation you need the following steps:

1. ``Commit`` your contributions to the XBeach documentation to your local ``clone``.
2. ``Push`` your ``commits`` from your local ``clone`` to the personal ``fork``.
3. At `http://github.com/<youraccount>/xbeach-docs` (personal ``fork``), submit a ``pull request``.
4. Your contributions will be offered to the original OpenEarth repository and tested for validity through [CircleCI](https://circleci.com). The status of the tests are displayed on the ``pull request`` page:
   - If all tests pass, you may preview the resulting documentation:
     - Click the ``Details`` link behind the [CircleCI](https://circleci.com) status indicator.
     - Go to the ``Artifacts`` tab.
     - Navigate to ``html/index.html``.
     - Note that equations are currently not rendered in [CircleCI](https://circleci.com).
   - If one or more tests fail, please review the failed tests:
     - Click the ``Details`` link behind the [CircleCI](https://circleci.com) status indicator.
     - Go to the ``Test Summary`` tab to review the failed tests.
     - Solve the errors in your local ``clone`` and repeat from step 1. until all tests pass.
5. If all tests passed, your contribution will be considered for merging with the XBeach documentation. You might receive additional requests through Github ``conversations``.
     

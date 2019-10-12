Package Textpattern CMS plugin GitHub Action
=====

This [GitHub Action](https://help.github.com/en/articles/about-github-actions) packages a source repository containing a [Textpattern CMS](https://textpattern.com) plugin and creates installers.

Usage
-----

[Create a workflow file](https://help.github.com/en/articles/configuring-a-workflow) that checkouts your source code and builds it:

```yaml
name: Example Workflow

on: [push]

jobs:
  build:
    name: Build
    runs-on: ubuntu-latest

    steps:

    - name: Checkout
      uses: actions/checkout@v1

    - name: Build
      id: build
      uses: gocom/action-textpattern-package-plugin@master

    - name: Print Built Installers
      run: |
        cat ${{ github.workspace }}/${{ steps.build.outputs.compressed }}
        cat ${{ github.workspace }}/${{ steps.build.outputs.uncompressed }}
```

See [rah_flat](https://github.com/gocom/rah_flat) repository for live [workflow examples](https://github.com/gocom/rah_flat/blob/master/.github/workflows), and [action results](https://github.com/gocom/rah_flat/actions) containing uploaded artifacts.

Input Arguments
-----

* **source**
  Path to the plugin source directory, relative to the repository root, if something else than repository root.
* **output**
  Path to the output directory where build artifacts are saved to, relative to `$GITHUB_WORKSPACE`. Defaults to `build/packages`.

Output Variables
-----

* **name**
  Name of the built plugin.
* **version**
  Version number from the manifest file.
* **compressed**
  Path to the compressed plugin installer file, relative to `$GITHUB_WORKSPACE`.
* **uncompressed**
  Path to the uncompressed plugin installer file, relative to `$GITHUB_WORKSPACE`.

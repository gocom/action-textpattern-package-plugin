Package Textpattern CMS plugin GitHub Action
=====

This GitHub Action packages a source repository containing a [Textpattern CMS](https://textpattern.com) plugin and creates installers.

Usage
-----

```yaml
name: Example Workflow

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:

    - name: Checkout
      uses: actions/checkout@v1

    - name: Build
      id: build
      uses: gocom/action-textpattern-package-plugin@master

    - name: Print Built Installers
      run: |
        cat ${{ steps.build.outputs.compressed }}
        cat ${{ steps.build.outputs.uncompressed }}
```

Input Arguments
-----

* **source**
  Path to the plugin source directory, relative to the repository root, if something else than repository root.
* **output**
  Path to the output directory where build artifacts are saved to, relative to ```$GITHUB_WORKSPACE```. Defaults to `build/packages`.

Output Variables
-----

* **name**
  Name of the built plugin.
* **version**
  Version number from the manifest file.
* **compressed**
  Path to the compressed plugin installer file.
* **uncompressed**
  Path to the uncompressed plugin installer file.

References
-----

* [Development tools for GitHub Actions](https://help.github.com/en/articles/development-tools-for-github-actions)
* [GitHub Action for creating GitHub Releases](https://github.com/softprops/action-gh-release)
* [An Action to upload a release asset via the GitHub Release API](https://github.com/actions/upload-release-asset)

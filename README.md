Package Textpattern CMS plugin GitHub Action
=====

This GitHub action packages a source repository containing a [Textpattern CMS](https://textpattern.com) plugin and creates installers.

Usage
=====

The action creates installers to `${{ github.workspace }}/packages/`.

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
      uses: gocom/action-textpattern-package-plugin@master

    - name: Echo Built Installers
      run: |
        cat ${{ github.workspace }}/packages/default/compressed
        cat ${{ github.workspace }}/packages/default/compressed
```

Input arguments
=====

* **source**
  Path to the plugin source directory, relative to the repository root.
* **name**
  Name of the created package. Defaults to `default`.

References
=====

* [Development tools for GitHub Actions](https://help.github.com/en/articles/development-tools-for-github-actions)
* [GitHub Action for creating GitHub Releases](https://github.com/softprops/action-gh-release)
* [An Action to upload a release asset via the GitHub Release API](https://github.com/actions/upload-release-asset)

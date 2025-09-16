# Changelog

## 0.3.0

* Push built image to the registry, so that it doesn't need to be built during the action run.
* Update the image's PHP runtime to 8.4.

## 0.2.0

* Drop use of deprecated `set-ouput` command. For more information, see https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/.

## 0.1.6

* Takes plugin version number from `GITHUB_REF`. The resulting plugin version will be resolved from the tag or
  branch name that triggered the run, allowing so that it does not need to be kept up-to-date in `manifest.json`.
* Update [mtxpc](https://github.com/gocom/MassPlugCompiler) to version 0.8.0.

## 0.1.5

* Update [mtxpc](https://github.com/gocom/MassPlugCompiler) to version 0.7.0.

## 0.1.4

* Update [mtxpc](https://github.com/gocom/MassPlugCompiler) to version 0.6.0.

## 0.1.3

* Migrate to the newer [mtxpc](https://github.com/gocom/MassPlugCompiler) plugin compiler version 0.4.0.

## 0.1.2

* No code changes, corrected README.md.

## 0.1.1

* Correct `compressed` and `uncompressed` output's paths.

## 0.1.0

* Initial release.

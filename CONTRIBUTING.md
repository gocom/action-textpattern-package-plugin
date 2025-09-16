Contributing
=====

License
-----

See [LICENSE](./LICENSE).

Versioning
-----

[Semantic Versioning](https://semver.org/).

Local development environment
-----

### Requirements

The local environment required:

* Docker
* GNU Make

### Available commands

To list available commands, run:

```shell
$ make help
```

Building
-----

The image is built and published automatically by CI. The CI builds automatically all git tags that follow
Semantic Versioning naming convention, and branches `main`, `master`, and those that match `release/*`. The image tag
is named after the tag's name, or the branch's last path component. For instance for branch `release/1.0`, the
image tag would be named as `1.0`.

### Building locally

To manually build the Docker image on your local system, run:

```shell
$ make build
```

Smoke testing
-----

The image can be manually tested on local before commiting changes with surface level smoke test. First, build
the image, and then run the test:

```shell
$ make build
$ make test
```

The test would clone example plugin repository to `.plugin`, and use the Docker image to build it. The build
results would be written to `.plugin/build/package` directory. `GITHUB_OUTPUT` is written to `.plugin/output.txt`
file.

<?php

require __DIR__ . '/vendor/autoload.php';

$workspace = \getenv('GITHUB_WORKSPACE') ?: \getcwd();
$source = \getenv('INPUT_SOURCE') ?: '';
$output = \getenv('INPUT_OUTPUT') ?: 'build/packages';

$package = (new \Rah\Mtxpc\Compiler())
    ->useCompression(true)
    ->compile("$workspace/$source");

$name = $package->getName();
$version = $package->getVersion();

$path = "${output}/${name}_v${version}_zip.txt";

file_put_contents($workspace . \DIRECTORY_SEPARATOR . $path, $package->getInstaller());

\fwrite(\STDOUT, "::set-output name=compressed::$path\n");

$package = (new \Rah\Mtxpc\Compiler())
    ->useCompression(false)
    ->compile("$workspace/$source");

$path = "${output}/${name}_v${version}.txt";

file_put_contents($workspace . \DIRECTORY_SEPARATOR . $path, $package->getInstaller());

\fwrite(\STDOUT, "::set-output name=uncompressed::$path\n");
\fwrite(\STDOUT, "::set-output name=version::$version\n");
\fwrite(\STDOUT, "::set-output name=name::$name\n");

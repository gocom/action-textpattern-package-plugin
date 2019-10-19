<?php

\set_error_handler(static function ($errno, $errstr, $errfile, $errline) {
    \fwrite(\STDERR, "$errno: $errstr in $errfile on line $errline\n");

    exit(1);
});

\set_exception_handler(static function ($exception) {
    \fwrite(\STDERR, $exception->getMessage() . "\n");

    exit(1);
});

require __DIR__ . '/vendor/autoload.php';

$workspace = \getenv('GITHUB_WORKSPACE') ?: \getcwd();
$source = \getenv('INPUT_SOURCE') ?: '';
$output = \getenv('INPUT_OUTPUT') ?: 'build/packages';

if (!\is_dir($output)) {
    \mkdir("$workspace/$output", 0755, true);
}

$package = (new \Rah\Mtxpc\Compiler())
    ->useCompression(true)
    ->compile("$workspace/$source");

$name = $package->getName();
$version = $package->getVersion();

$path = "${output}/${name}_v${version}_zip.txt";

\file_put_contents($workspace . \DIRECTORY_SEPARATOR . $path, $package->getInstaller());

\fwrite(\STDOUT, "::set-output name=compressed::$path\n");

$package = (new \Rah\Mtxpc\Compiler())
    ->useCompression(false)
    ->compile("$workspace/$source");

$path = "${output}/${name}_v${version}.txt";

\file_put_contents($workspace . \DIRECTORY_SEPARATOR . $path, $package->getInstaller());

\fwrite(\STDOUT, "::set-output name=uncompressed::$path\n");
\fwrite(\STDOUT, "::set-output name=version::$version\n");
\fwrite(\STDOUT, "::set-output name=name::$name\n");

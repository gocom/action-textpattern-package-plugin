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

$stdout = \getenv('GITHUB_OUTPUT') ?: 'output.txt';
$workspace = \getenv('GITHUB_WORKSPACE') ?: \getcwd();
$source = \getenv('INPUT_SOURCE') ?: '';
$output = \getenv('INPUT_OUTPUT') ?: 'build/packages';
$ref = \getenv('GITHUB_REF');
$inputVersion = $ref
    ? \basename($ref)
    : '0.0.0';

if (!\is_dir($output)) {
    \mkdir("$workspace/$output", 0755, true);
}

$package = (new \Rah\Mtxpc\Compiler())
    ->useCompression(true)
    ->setVersion($inputVersion)
    ->compile("$workspace/$source");

$name = $package->getName();
$version = $package->getVersion();

$path = \sprintf(
    '%s/%s_v%s_zip.txt',
    $output,
    $name,
    $version
);

\file_put_contents($workspace . \DIRECTORY_SEPARATOR . $path, $package->getInstaller());

\file_put_contents($stdout, "compressed=$path\n", \FILE_APPEND);

$package = (new \Rah\Mtxpc\Compiler())
    ->useCompression(false)
    ->setVersion($inputVersion)
    ->compile("$workspace/$source");

$path = \sprintf(
    '%s/%s_v%s.txt',
    $output,
    $name,
    $version
);

\file_put_contents($workspace . \DIRECTORY_SEPARATOR . $path, $package->getInstaller());

\file_put_contents($stdout, "uncompressed=$path\n", \FILE_APPEND);
\file_put_contents($stdout, "version=$version\n", \FILE_APPEND);
\file_put_contents($stdout, "name=$name\n", \FILE_APPEND);

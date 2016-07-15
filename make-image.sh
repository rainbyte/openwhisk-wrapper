#!/usr/bin/env bash
set -xe
docker build -t build_haskell-hello -f Dockerfile.build .
docker run --rm \
    --volume="$PWD/.stack-root:/stack-root" \
    --volume="$PWD:/src" \
    --volume="$PWD/artifacts:/artifacts" \
    build_haskell-hello
docker build -t rainbyte/openwhisk-example-hs .

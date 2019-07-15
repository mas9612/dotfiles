#!/bin/bash

GOPKGS=("github.com/go-delve/delve/cmd/dlv")
for pkg in $GOPKGS; do
    echo "Installing ${pkg}"
    go get -u ${pkg}
done

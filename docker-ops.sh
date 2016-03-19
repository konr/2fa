#!/bin/bash

set -euo pipefail

registry="konr"
image=2fa
remote="${registry}/${image}"
sha=$(git rev-parse --short HEAD)

build() {
    docker build -t "${image}:${sha}" .

    if [[ $? -ne 0 ]]; then
        echo "Build Failed."
        exit 1
    fi

    docker tag -f ${image}:${sha} ${image}:latest
}

push() {
    for target in ${sha} latest; do

        docker tag -f ${image}:${target} ${remote}:${target}
        docker push ${remote}:${target}

        if [[ $? -ne 0 ]]; then
            echo "Push Failed."
            exit 1
        fi
    done

}

case "$1" in
    build)
        build
        ;;
    push)
        push
        ;;
    *)
        echo "Usage: $0 <build|push>"
        ;;
esac

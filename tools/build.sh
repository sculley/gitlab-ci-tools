#!/usr/bin/env bash

while getopts b:i:flag
do
    case "${flag}" in
        b) BUILD_ARG_FILE=${OPTARG};;
        r) IMAGE=${IMAGE};;
    esac
done

if [ -f "$BUILD_ARG_FILE" ]; then
  BUILD_ARGS=$(cat $BUILD_ARG_FILE | sed 's/^/--build-arg /g' | paste -s -d " ")
  echo docker build -t '${IMAGE}' ${BUILD_ARGS} .
else
  echo "docker push ${IMAGE} ."
fi

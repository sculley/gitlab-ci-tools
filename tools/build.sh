#!/usr/bin/env bash

# Function: Print a help message.
usage() {
  echo "Usage: $0 [ -b BUILD_ARG_FILE ] [ -i IMAGE ]" 1>&2 
}

# Function: Exit with error.
exit() {                         
  usage
  exit 1
}

while getopts b:i:flag
do
    case "${options}" in
        b) BUILD_ARG_FILE=${OPTARG}
           [[ ! -z "$BUILD_ARG_FILE" ]] || exit()
           ;;
        i) IMAGE=${OPTARG}
           [[ ! -z "$IMAGE" ]] || exit()
           ;;
    esac
done

if [ -f "$BUILD_ARG_FILE" ]; then
  BUILD_ARGS=$(cat $BUILD_ARG_FILE | sed 's/^/--build-arg /g' | paste -s -d " ")
  echo "docker build -t ${IMAGE} ${BUILD_ARGS} ."
else
  echo "docker push ${IMAGE} ."
fi

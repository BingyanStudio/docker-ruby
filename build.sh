#!/usr/bin/env sh

set -xe

cd "$SUBDIR"

[ -x before_build.sh ] && ./before_build.sh

: ${VERSION:=$(basename $(pwd))}
IMAGE=${IMAGE_PREFIX}${IMAGE_NAME}:${TAG_PREFIX}${VERSION}

if [ -f .version ]; then
    for x in $(cat .version); do
        TAGS="$TAGS ${TAG_PREFIX}${x}"
    done
fi

docker build -t $IMAGE -f Dockerfile .
echo $IMAGE >> "$PUSH_LIST"

for x in $TAGS; do
    alias=${IMAGE%%:*}:$x
    docker tag $IMAGE $alias
    echo "$alias" >> "$PUSH_LIST"
done


[ -x after_build.sh ] && ./after_build.sh

return 0

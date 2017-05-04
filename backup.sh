#!/bin/bash
source=$1
target=$2

function help {
  echo Usage: $0 SOURCE TARGET
}

if [ "$source" = "" ] || [ "$target" = "" ]; then
  help
  exit 1
fi

source=$(cd $source; pwd)
dockerSource=/duplicity.d${source}
echo Backing up $source to $target
docker run -it -v ~/.docker-duplicity:/root:rw -v /:/duplicity.d:ro docker-duplicity duplicity ${dockerSource} ${target}

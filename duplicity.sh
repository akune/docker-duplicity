#!/bin/bash
params=( "$@" )
paramCount=${#params[@]}

function isUrl {
  if [[ $1 == *'://'* ]]; then
    return 0
  else
    return -1
  fi
}

function toContainerPath {
  result=$(cd $1 2>/dev/null && pwd || echo "")
  if [ "$result" = "" ]; then
    echo $1
  else 
    echo /duplicity.d${result}
  fi
}

for (( i=$(($paramCount>1?$paramCount-2:0)); i<$paramCount; i++ )); do
  if ! isUrl ${params[$i]}; then
    params[$i]=$(toContainerPath ${params[$i]})
  fi
done

docker run -it -v ~/.docker-duplicity:/root:rw -v /:/duplicity.d:ro docker-duplicity duplicity ${params[@]}

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

function isLocalPath {
  if isUrl $1; then
    return -1
  fi
#  if [[ $1 == '-'* ]]; then
#    return 0
#  else
#    return -1
#  fi
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
  if isLocalPath ${params[$i]}; then
echo ${params[$i]}
    params[$i]=$(toContainerPath ${params[$i]})
echo ${params[$i]}
  fi
done

echo "docker run -it -v ~/.docker-duplicity:/root:rw -v /:/duplicity.d:rw kune/docker-duplicity duplicity ${params[@]}"
docker run -it -v ~/.docker-duplicity:/root:rw -v /:/duplicity.d:rw kune/docker-duplicity duplicity ${params[@]}

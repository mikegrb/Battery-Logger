#!/usr/bin/env bash

SCRIPTPATH=$( builtin cd $(dirname $0) ; pwd -P )

source="$1"
destination="$2"

if [[ -z "$source" || -z "$destination" ]] ; then
    echo 'Usage: ./plot.sh $source_path $destination_path'
    exit 1
fi

gnuplot -e "source = '$source'" -e "destination = '$destination'" "$SCRIPTPATH/gnuplot"


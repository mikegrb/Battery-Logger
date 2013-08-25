#!/usr/bin/env bash

SCRIPTPATH=$( builtin cd $(dirname $0) ; pwd -P )

source="$1"
destination="$2"

if [[ -z "$source" || -z "$destination" ]] ; then
    echo 'Usage: ./plot.sh $source_path $destination_path ($path_of_gnuplot)'
    exit 1
fi

if [ -n "$3" ] ; then
    command="$3"
elif [ -n "$(command -v gnuplot)" ] ; then
    command="$(command -v gnuplot)"
else
    echo "Couldn't find gnuplot"
    exit 1
fi

exec $command -e "source = '$source'" -e "destination = '$destination'" "$SCRIPTPATH/gnuplot"


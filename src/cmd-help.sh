#!/usr/bin/env bash
#
# Help for top-level Auriel commands

# narrows the help to a specific sub-command
if [ -n "$1" ]
then
    CMD=$1
fi

cat "$AURIEL_SOURCE_DIR/help-$CMD.txt"


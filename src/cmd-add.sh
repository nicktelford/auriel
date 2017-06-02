#!/usr/bin/env bash
#
# Adds one or more packages to the Auriel repo

check_help "$1" "add"

for pkg in $@
do
    (process "Adding $pkg from AUR" &&
        call_git submodule add "$AUR_BASE_URL/$pkg" &&
        call_git add $pkg &&
        call_git commit -m "Add package from AUR: $pkg" &&
        ok) || fail

    shift
done


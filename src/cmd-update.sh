#!/usr/bin/env bash
#
# Updates one or more, or all packages in the Auriel repo

check_help "$1" "update"

if [ $# -gt 0 ]
    (process "Updating $@ from AUR" &&
        call_git submodule update --remote $@ &&
        call_git add -u -- $@ &&
        call_git commit -m "Update $(count_pkgs $@) packages from AUR\n\n$(list_pkgs $@)" &&
        ok) || fail
else
    (process "Updating $(count_pkgs) packages from AUR" && \
        call_git submodule update --remote && \
        call_git add -u -- "$(list_pkgs)" && \
        call_git commit -m "Update $(count_pkgs) packages from AUR\n\n$(list_pkgs)" &&
        ok) || fail
fi


#!/usr/bin/env bash
#
# Removes one or more packages

check_help "$1" "remove"

require_sudo

for pkg in $@
do
    (process "Removing $pkg" && \
        call_git submodule deinit --force "$pkg" && \
        call_git rm "$pkg" && \
        run "rm -rf $AURIEL_REPO_DIR/.git/modules/$pkg" && \
        run "sudo pacman -R $pkg" && \
        ok) || fail
done


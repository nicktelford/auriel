#!/usr/bin/env bash
#
# Installs one or more packages from the AUR

check_help "$1" "install"

require_sudo

if [ $# -gt 0 ]
    for pkg in $@
    do
        (process "Installing $pkg from AUR" && \
            call_git submodule add "$AUR_BASE_URL/$pkg" && \
            run "(cd $AURIEL_REPO_DIR/$pkg && makepkg $AURIEL_MAKEPKG_OPTS)" && \
            ok) || fail
    done
else
    (process "Installing $(count_pkgs) packages from AUR" && \
        call_git submodule foreach makepkg "$AURIEL_MAKEPKG_OPTS" && \
        ok) || fail
fi


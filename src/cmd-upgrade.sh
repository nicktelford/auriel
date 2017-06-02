#!/usr/bin/env bash
#
# Upgrades one or more, or all packages in the Auriel repo

check_help "$1" "upgrade"

require_sudo

if [ $# -gt 0 ]
    (process "Upgrading $@ from AUR" \
        call_git submodule update --remote $@ && \
        run "(cd $AURIEL_REPO_DIR/$pkg && makepkg $AURIEL_MAKEPKG_OPTS)" &&
        ok) || fail
else
    (process "Upgrading $(count_pkgs) packages from AUR" && \
        call_git submodule update --remote && \
        call_git submodule foreach makepkg "$AURIEL_MAKEPKG_OPTS" && \
        ok) || fail
fi


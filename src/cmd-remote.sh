#!/usr/bin/env bash
#
# Configures the git remote(s) on the Auriel repo

check_help "$1" "remote"

call_git remote $@


#!/usr/bin/env bash
#
# Pushes the Auriel repo to the configured remote

check_help "$1" "push"

call_git push $@



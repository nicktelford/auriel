#!/usr/bin/env bash
#
# Pulls the Auriel repo from the configured remote

check_help "$1" "pull"

call_git pull $@


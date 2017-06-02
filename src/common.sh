#!/usr/bin/env bash
#
# Common functions for Auriel
#

ANSI_GREEN="\e[0;32m"
ANSI_RED="\e[0;31m"
ANSI_YELLOW="\e[1;33m"
ANSI_BLUE="\e[1;34m"
ANSI_RESET="\e[0m"

function usage() {
    cat "$AURIEL_SOURCE_DIR/usage"
}

function check_help() {
    if [ "$1" == "--help" ]
    then
        help "$2"
    fi
}

function help() {
    if [ -n "$1" ]; then
        source "$AURIEL_SOURCE_DIR/cmd-help.sh" "$1"
    else
        source "$AURIEL_SOURCE_DIR/cmd-help.sh"
    fi
    exit 0
}

function fatal() {
    error $@
    exit 1
}

function error() {
    (>&2 echo -e "${ANSI_RED}auriel:${ANSI_RESET} $@")
    return 0
}

function warn() {
    (>&2 echo -e "${ANSI_YELLOW}auriel:${ANSI_RESET} $@")
    return 0
}

function require() {
	for name in $*; do
		file=$(which "$name")
		if [ $? -ne 0 -o ! -x "$file" ]; then
			error "Required program '$name' not found. Please ensure it is installed and on your PATH."
		fi
	done
}

function require_sudo() {
    sudo true
}

function process() {
    echo -en "$1..."
	shift
	if [ $# -gt 0 ]; then
		exec 3>&1 # set up extra file descriptor for stdout redirection
		LAST_ERROR=$({ eval "$@" 1>&3; } 2>&1) # capture any stderr
        local retval=$? # capture exit status
		exec 3>&- # close extra file descriptor
		return $retval
	fi
    return 0
}

function ok() {
	echo -e "${ANSI_GREEN}OK${ANSI_RESET}"
    display_error
    return 0
}

function fail() {
	echo -e "${ANSI_RED}FAILED${ANSI_RESET}"
    display_error
	return 1
}

function skipped() {
	echo -e "${ANSI_YELLOW}SKIPPED${ANSI_RESET}"
    display_error
	return 0
}

LAST_ERROR=

function display_error() {
	if [ -n "$LAST_ERROR" ]; then
		error "$LAST_ERROR"
		LAST_ERROR=""
	fi
}

function contains_element() {
    local e
    for e in "${@:2}"
    do
        [[ "$e" == "$1" ]] && return 0
    done
    return 1
}

function run() {
    exec 3>&1 # set up extra file descriptor for stdout redirection
    LAST_ERROR=$({ eval "$@" 1>&3; } 2>&1) # capture any stderr
    local retval=$? # capture exit status
    exec 3>&- # close extra file descriptor
    return $retval
}

function call_git() {
    local git_quiet=""
    if [ contains_element "$1" "submodule commit rm push pull" ]
    then
        git_quiet="--quiet"
    fi
    
    exec 3>&1 # set up extra file descriptor for stdout redirection
    LAST_ERROR=$({
        eval git -C $AURIEL_REPO_PATH $1 $git_quiet ${@:2} 1>&3;
    } 2>&1) # capture any stderr
    retval=$? # capture exit status
    exec 3>&- # close extra file descriptor
    return $retval
}

function list_pkgs() {
    filter="*"
    if [ $# -gt 0 ]; then
        filter=$@
    fi

    (cd $AURIEL_REPO_PATH && ls -d "$filter")
    return $?
}

function count_pkgs() {
    echo $(list_pkgs | wc -w)
    return $?
}

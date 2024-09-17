#!/bin/bash

##############################
# VARIABLE GLOBAL
#-----------------------------
# Pour aider ...
# ----------------------------
SCRIPT_DIR=$SCRIPT_DIR
WORKSPACE_DIR=$WORKSPACE_DIR

CFLAGS=$CFLAGS
CFLAGSW=$CFLAGSW
CFLAGS_VALGRIND=$CFLAGS_VALGRIND
OUT_DIR=$OUT_DIR
TIG_DIR=$TIG_DIR
PROJET_NAME=$PROJET_NAME
# ----------------------------
WORKSPACE_PATH=$WORKSPACE_PATH

SCRIPT_PATH=$SCRIPT_PATH
OUT_PATH=$OUT_PATH
##############################

DOT="\033[1;32m:\033[0m"
PLUS="\033[32m+\033[0m"
MINUS="\033[31m-\033[0m"
LIGHT_GREY='\033[38;5;250m'
DARK_GREY='\033[38;5;240m'
function info_workspace() {
	local symbole=$MINUS
	if [ -e "$WORKSPACE_DIR/$1/.git" ]; then
		symbole=$PLUS
	fi
	echo -e "\033[34m$symbole$1$DOT $DARK_GREY$2$NO_COLOR"
}

function list_workspace() {
	foreach_workspace info_workspace
}

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


function test_workspase() {
	local PROJET_NAME=$1
	clear
	echo "-------------------------"
	echo -e "${Title}PROJET_NAME${Normal}= $PROJET_NAME |PID: $$"
	echo "-------------------------"
	source $PWD/$SCRIPT_DIR/$PROJET_NAME/test.sh
	make_test
}

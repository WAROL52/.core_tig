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

function excec_file() {
	PROJET_NAME=$1
	WORKSPACE_PATH=$WORKSPACE_DIR/$PROJET_NAME
	SCRIPT_PATH=$SCRIPT_DIR/$PROJET_NAME
	OUT_PATH=$OUT_DIR/$PROJET_NAME
	local cmdfile=$PWD/$MAKE_CMD_DIR/$PROJET_NAME/$2.sh
	local makecmd="make_$2"
	local date_excec=$(date "+%H:%M:%S")
	if [ -f $cmdfile ]; then
		screenHeader "$PROJET_NAME |PID: $$ | $date_excec"
		source $cmdfile
		$makecmd
		screenFooter
	else
		log_info "Warning:" "$cmdfile introuvable!"
	fi
}

function run_workspace() {
	excec_file $1 run
}

function test_workspace() {
	excec_file $1 test
}


function perf_workspace() {
	excec_file $1 perf
}

function clear_workspace() {
	excec_file $1 clear
}

function init_workspace() {
	excec_file $1 init
}

function cmd_workspace() {
	excec_file $1 cmd
}

function run_w_workspace() {
	clear
	run_workspace $1
}


function test_w_workspace() {
	clear
	test_workspace $1
}

function perf_w_workspace() {
	clear
	perf_workspace $1
}

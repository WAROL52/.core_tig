#!/bin/bash

##############################
# VARIABLE GLOBAL
#-----------------------------
# Pour aider ...
# ----------------------------
readonly SCRIPT_DIR=$SCRIPT_DIR
readonly WORKSPACE_DIR=$WORKSPACE_DIR
readonly 
readonly CFLAGS=$CFLAGS
readonly CFLAGSW=$CFLAGSW
readonly CFLAGS_VALGRIND=$CFLAGS_VALGRIND
readonly OUT_DIR=$OUT_DIR
readonly TIG_DIR=$TIG_DIR
readonly PROJET_NAME=$PROJET_NAME
# ----------------------------
readonly WORKSPACE_PATH=$WORKSPACE_PATH
readonly 
readonly SCRIPT_PATH=$SCRIPT_PATH
readonly OUT_PATH=$OUT_PATH
##############################

function make_test() {
	local tmp=$OUT_PATH/tmp
	local tmpVClient=$OUT_PATH/tmpVClient
	local args=$(head -n 1 $SCRIPT_PATH/args.txt)
	mkdir -p $OUT_PATH
	cd $WORKSPACE_PATH

	make bonus CFLAGS="$CFLAGS $CFLAGSW" > $tmp
	if [ $? -gt 0 ]; then
    	echo "Les chaînes sont identiques."
	else
		git clone https://github.com/LeoFu9487/push_swap_tester.git
	fi
}

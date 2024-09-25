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

function add_workspace() {
	cd $TIG_DIR
	cd ..
	mkdir -p $MAKE_CMD_DIR
	create_conf $1 $2 $3
	git submodule add -f $2 $WORKSPACE_DIR/$1
	cp -r "$TIG_DIR/bash/template/[exemple]" "$TIG_DIR/bash/template/$1"
	chmod 777 $TIG_DIR/bash/template/$1/*
	mv "$TIG_DIR/bash/template/$1" $MAKE_CMD_DIR
}

function add_all_workspace() {
	echo -e "Les changements locaux dans ${OBJ_COLOR}$WORKSPACE_DIR/*${NO_COLOR} seront perdus."
	printf "${URL_COLOR}Voulez-vous continuer ? (oui/non): ${NO_COLOR}"
	read reponse
	if [[ "$reponse" == "oui" || "$reponse" == "o" || "$reponse" == "O" ]]; then
		delete_all_workspace
		foreach_workspace_default add_workspace
	else
		echo "Annulation de la commande."
	fi
}

function delete_workspace() {
	local name=$1
	local conf_file="$TIG_DIR/register/$name"
	if [ -f $conf_file ]; then
		rm -rf $conf_file
	fi
	sed -i "/^\[submodule \"Workspace\/$1\"\]/,+2d" .gitmodules
	rm -rf $WORKSPACE_DIR/$1 $MAKE_CMD_DIR/$1 $PWD/.git/modules/$WORKSPACE_DIR/$1
}

function delete_all_workspace() {
	echo -e "Les changements locaux dans ${OBJ_COLOR}$WORKSPACE_DIR/*${NO_COLOR} seront efface."
	printf "${URL_COLOR}Voulez-vous continuer ? (oui/non): ${NO_COLOR}"
	read reponse
	if [[ "$reponse" == "oui" || "$reponse" == "o" || "$reponse" == "O" ]]; then
		foreach_workspace delete_workspace
	else
		echo "Annulation de la commande."
	fi
}

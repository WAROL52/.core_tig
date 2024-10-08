####################################
include $(TIG_DIR)/core/Makefile ###
####################################


define bash_function
	bash -c 'source ./$(TIG_DIR)/bash/core.sh TIG_DIR=$(TIG_DIR) && $1 $2 $3 $4 $5 $6 $7 $8 $9'
endef

GIT_TARGET=$(GIT_PREFIX_ALIAS)$(SEPARATOR)
gitalias=$(foreach _alias,$1,$(GIT_TARGET)$(_alias))
gitaliasWithargs=$(foreach _alias,$1,$(GIT_TARGET)$(_alias)\:$(if $2,$2,%))
gitaliasArg=$(shell echo $1 | sed 's/$(GIT_TARGET).*://g')

$(call gitalias,$(GIT_ALIAS_ADD)):
	@$(call bash_function,add_all_workspace)
	@$(call logEnd,$@)

$(call gitaliasWithargs,$(GIT_ALIAS_ADD)):
ifdef url
	@$(call bash_function,add_workspace,$(call gitaliasArg,$@),$(url))
else
	@echo "La variable $(call textObj,url)est réquise!"
endif
	@$(call logEnd,$@)


$(call gitalias,$(GIT_ALIAS_LIST)):
	@$(call bash_function,list_workspace)
	@$(call logEnd,$@)

$(call gitalias,$(GIT_ALIAS_DELETE)):
	@$(call bash_function,delete_all_workspace)
	@$(call logEnd,$@)

$(call gitaliasWithargs,$(GIT_ALIAS_DELETE)):
	@$(call bash_function,delete_workspace,$(call gitaliasArg,$@))
	@$(call logEnd,$@)

$(call gitalias,$(GIT_ALIAS_INSTALL)):
	@$(call bash_function,install_all_workspace)
	@$(call logEnd,$@)

$(call gitaliasWithargs,$(GIT_ALIAS_INSTALL)):
	@$(call bash_function,install_workspace,$(call gitaliasArg,$@))
	@$(call logEnd,$@)

$(call gitalias,$(GIT_ALIAS_REMOVE)):
	@$(call bash_function,remove_all_workspace)
	@$(call logEnd,$@)

$(call gitaliasWithargs,$(GIT_ALIAS_REMOVE)):
	@$(call bash_function,remove_workspace,$(call gitaliasArg,$@))
	@$(call logEnd,$@)

$(call gitalias,$(GIT_ALIAS_PUSH)):
	@$(call bash_function,push_all_workspace)
	@$(call logEnd,$@)

$(call gitaliasWithargs,$(GIT_ALIAS_PUSH)):
	@$(call bash_function,push_workspace,$(WORKSPACE_DIR)/$(call gitaliasArg,$@))
	@$(call logEnd,$@)

$(call gitalias,$(GIT_ALIAS_PULL)):
	@$(call bash_function,pull_workspace)
	@$(call logEnd,$@)

$(call gitaliasWithargs,$(ALIAS_RUN)):
	@$(call bash_function,run_workspace,$(call gitaliasArg,$@))
	@$(call logEnd,$@)

$(call gitaliasWithargs,$(ALIAS_TEST)):
	@$(call bash_function,test_workspace,$(call gitaliasArg,$@))
	@$(call logEnd,$@)

$(call gitaliasWithargs,$(ALIAS_PERF)):
	@$(call bash_function,perf_workspace,$(call gitaliasArg,$@))
	@$(call logEnd,$@)

GET_PATERN=./$(MAKE_CMD_DIR)/$1/**/*$2 ./$(WORKSPACE_DIR)/$1/**/*$2
PATERN_C= $(call GET_PATERN,$1,.c) $(call GET_PATERN,$1,.h) $(call GET_PATERN,$1,.cpp)
PATERN_CMD= $(call GET_PATERN,$1,.sh)
PATERN_TXT= $(call GET_PATERN,$1,.txt) $(call GET_PATERN,$1,.text)
PATERN_MAKEFILE= $(call GET_PATERN,$1,Makefile)
PATERN_PY= $(call GET_PATERN,$1,.py)
PATERN_BER= $(call GET_PATERN,$1,.ber)

PATERN_ALL= $(call PATERN_BER,$1) $(call PATERN_C,$1) $(call PATERN_CMD,$1) $(call PATERN_MAKEFILE,$1) $(call PATERN_PY,$1) $(call PATERN_TXT,$1)
DEPS=



env:
	echo "$(call gitaliasWithargs,$(ALIAS_RUN_WATCH))"
	@$(call echoObj,MY_NAME:,$(MY_NAME))
	@$(call echoObj,CC:,$(CC))
	@$(call echoObj,TMP_SRC:,$(TMP_SRC))
	@$(call echoObj,LOG_SRC:,$(LOG_SRC))
	@$(call echoObj,CFLAGS:,$(CFLAGS))
	@$(call echoObj,OUT_DIR:,$(OUT_DIR))
	@$(call echoObj,RUN_DIR:,$(RUN_DIR))
	@$(call echoObj,GITHUB_URL_DEFAULT:,$(GITHUB_URL_DEFAULT))
	@echo

help:
	@(python3 -m pip list | grep "rich" || python3 -m pip install rich --user ) > $(TIG_DIR)/buff
	@python3 -m rich.markdown README.md

clean\:%:
	$(call make_clean_c)
	@$(call logEnd,$@)

fclean:
	$(call make_fclean_c)
	@$(call logEnd,$@)

watch:
	$(eval COMMANDS=$(subst ", \", $(COMMANDS)))
	@$(call make_watch,$(COMMANDS),$(DEPS))

script-save\:%:
	@$(call bash_function,script_save_workspace,$(subst script-save:,,$@))
	@$(call logEnd,$@)

script-delete\:%:
	@$(call bash_function,script_delete_workspace,$(subst script-delete:,,$@))
	@$(call logEnd,$@)

script-list:
	@$(call bash_function,script_list_workspace)
	@$(call logEnd,$@)

script-set\:%:
	@$(call bash_function,script_set_workspace,$(subst script-set:,,$@))
	@$(call logEnd,$@)

script-get\:%:
	@$(call bash_function,script_get_workspace,$(subst script-get:,,$@))
	@$(call logEnd,$@)

$(call gitaliasWithargs,$(ALIAS_RUN_WATCH)):
	@rm -rf out/*.a
	@sleep 0.5 ; clear
	@$(call make_watch, $(call bash_function,run_w_workspace,$(call gitaliasArg,$@)),$(call PATERN_ALL,$(call gitaliasArg,$@)$(DEPS)))
	@$(call logEnd,$@)

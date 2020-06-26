DOTFILES_EXCLUDES	:= .DS_Store .git .gitmodules .travis.yml
DOTFILES_SPECIAL	:= .config
DOTFILES			:= $(wildcard .??*) $(wildcard $(DOTFILES_SPECIAL)/??*)
DOTFILES_DIR		:= $(PWD)
DOTFILES_TARGET		:= $(filter-out $(DOTFILES_EXCLUDES) $(DOTFILES_SPECIAL), $(DOTFILES))

deploy:
	@$(foreach val, $(DOTFILES_TARGET), rm -rf C:/Users/upnt/AppData/Local/$(notdir $(val)); ln -sv $(abspath $(val)) C:/Users/upnt/AppData/Local/$(notdir $(val));)

init:
	@$(foreach val, $(willdcard ./etc/init/*.sh), bash $(val);)

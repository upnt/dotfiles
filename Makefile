DOTFILES_SPECIAL	:= .config

deploy:
	@$(foreach val, $(willdcard ./etc/deploy/*.sh), sh $(val);)
	@$(foreach val, $(DOTFILES_SPECIAL), cd $(val) && make deploy;)

init:
	@$(foreach val, $(willdcard ./etc/init/*.sh), sh $(val);)
	@$(foreach val, $(DOTFILES_SPECIAL), cd $(val) && make deploy

deploy:
	@$(foreach val, $(willdcard ./etc/deploy/*.sh), bash $(val);)

init:
	@$(foreach val, $(willdcard ./etc/init/*.sh), bash $(val);)

.PHONY: all
all: nvim zsh tmux

nvim:
	-git clone https://github.com/upnt/nvim-myastro ~/.config/nvim 

zsh:
	-ln -s $(abspath ${CURDIR})/rc/zsh/.zshrc $(abspath ${HOME})/.zshrc

tmux:
	-ln -s $(abspath ${CURDIR})/rc/tmux/.tmux.conf $(abspath ${HOME})/.tmux.conf
	
.PHONY: test
test: 

.PHONY: clean
clean:
	$(RM) -r ~/.config/nvim
	$(RM) ~/.zshrc
	$(RM) ~/.tmux.conf

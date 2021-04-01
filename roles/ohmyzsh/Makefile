files/ohmyzsh.tar.gz: .oh-my-zsh .oh-my-zsh/custom/plugins/zsh-autosuggestions .oh-my-zsh/custom/plugins/zsh-completions .oh-my-zsh/custom/plugins/zsh-syntax-highlighting .oh-my-zsh/custom/themes/mh-hostname.zsh-theme
	tar cf $@ $^
	rm -rf .oh-my-zsh

.oh-my-zsh:
	git clone https://github.com/ohmyzsh/ohmyzsh.git $@
	touch $@

.oh-my-zsh/custom/plugins/zsh-autosuggestions:
	git clone https://github.com/zsh-users/zsh-autosuggestions.git $@
	touch $@

.oh-my-zsh/custom/plugins/zsh-completions:
	git clone https://github.com/zsh-users/zsh-completions.git  $@
	touch $@

.oh-my-zsh/custom/plugins/zsh-syntax-highlighting:
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git  $@
	touch $@

.oh-my-zsh/custom/themes/mh-hostname.zsh-theme:
	wget http://raw.githubusercontent.com/Honiix/oh-my-zsh/master/themes/mh-hostname.zsh-theme -O $@
	touch $@

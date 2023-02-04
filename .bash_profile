if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi

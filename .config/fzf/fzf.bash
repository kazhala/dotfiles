if [[ "$OS_DISTRO" == "MACOS" ]]; then
	source "/usr/local/opt/fzf/shell/completion.bash"
	source "/usr/local/opt/fzf/shell/key-bindings.bash"
elif [[ "$OS_DISTRO" =~ .*UBUNTU ]]; then
	source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/completion.bash"
	source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.bash"
fi

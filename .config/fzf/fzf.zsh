if [[ "$OS_DISTRO" == "MACOS" ]]; then
  source "/usr/local/opt/fzf/shell/completion.zsh"
  source "/usr/local/opt/fzf/shell/key-bindings.zsh"
elif [[ "$OS_DISTRO" == "UBUNTU" ]]; then
  source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/completion.zsh"
  source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.zsh"
fi

if [[ "$OS_DISTRO" == "MACOS" ]]; then
  source "/usr/local/opt/fzf/shell/completion.zsh"
  source "/usr/local/opt/fzf/shell/key-bindings.zsh"
elif [[ "$OS_DISTRO" == "UBUNTU" ]]; then
  source "/usr/share/doc/fzf/examples/completion.zsh"
  source "/usr/share/doc/fzf/examples/key-bindings.zsh"
fi

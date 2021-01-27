if [[ "$OS_DISTRO" == "MACOS" ]]; then
  source "/usr/local/opt/fzf/shell/completion.bash"
  source "/usr/local/opt/fzf/shell/key-bindings.bash"
elif [[ "$OS_DISTRO" == "UBUNTU" ]]; then
  source "/usr/share/doc/fzf/examples/key-bindings.bash"
  source "/usr/share/doc/fzf/examples/completion.bash"
fi

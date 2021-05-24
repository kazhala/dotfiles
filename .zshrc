# -- INIT ----------------------------------------------------------------------

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -- ZINIT ---------------------------------------------------------------------

if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
  command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
  command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# -- PLUGINS -------------------------------------------------------------------

zinit ice depth=1
zinit light romkatv/powerlevel10k

zinit wait lucid light-mode for \
  ver="dev" \
  atload'bindkey "^u" dotbare-transform;
  bindkey "^d" dotbare-fedit' \
    kazhala/dotbare \
  kazhala/bmux \
  kazhala/dump-cli \
  https://github.com/kazhala/scripts/blob/master/shell/fbookmark \
  https://raw.githubusercontent.com/aws/aws-cli/develop/bin/aws_zsh_completer.sh \
  atload'bindkey -M vicmd "k" history-substring-search-up;
  bindkey -M vicmd "j" history-substring-search-down' \
    zsh-users/zsh-history-substring-search \
  atload'_zsh_autosuggest_start;
  bindkey -v "^b" autosuggest-accept' \
    zsh-users/zsh-autosuggestions \
  atinit'ZINIT[COMPINIT_OPTS]=-C;
  zicompinit;
  zicdreplay;
  _dotbare_completion_cmd;
  complete -o nospace -C "$(which terraform)" terraform;
  eval "$(register-python-argcomplete pipx)"' \
  atload"FAST_HIGHLIGHT[chroma-man]=" \
    zdharma/fast-syntax-highlighting

# -- SETTINGS -----------------------------------------------------------------

# history
HISTSIZE=50000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history

# completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh/completion
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' \
  max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
expand-or-complete-with-dots() {
  [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti rmam
  print -Pn "%{%F{red}......%f%}"
  [[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti smam

  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots
zmodload zsh/complist
LISTMAX=9999

# edit current line in vim
autoload -Uz edit-command-line
zle -N edit-command-line

# comments and process sub in propmt
setopt interactive_comments
setopt prompt_subst

# directory stack
setopt pushd_ignore_dups
setopt auto_pushd
setopt pushdminus

# misc
setopt nobeep
setopt ignoreeof

# -- PATH ----------------------------------------------------------------------

export PATH="$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH"
export PATH="$HOME/Programming/scripts/shell:$PATH"
export PATH="${XDG_DATA_HOME:-$HOME/.local/share}/cargo/bin:$PATH"

# -- ALIASES -------------------------------------------------------------------

alias vim="nvim"
alias vimf="nvim '+Dashboard | FloatermNew vifm'"
alias py3="python3"
alias tree="tree -I '.git|node_modules|bower_components|.DS_Store|build'"
alias ag="ag -p ~/.ignore"
alias lg="lazygit"
alias ll="lsd -lAF --group-dirs first"
alias ls="lsd"
alias ..="cd .."
alias mv="mv -v"
alias cp="cp -v"
alias rm="rm -v"
alias grep="grep --color=auto"
alias fs="bmux"
alias tf="terraform"

# -- SYSTEM ENV ----------------------------------------------------------------

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export EDITOR=nvim
export TERM="xterm-256color"
export COLORTERM="truecolor"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# -- MISC ----------------------------------------------------------------------

export GRIPHOME="${XDG_CONFIG_HOME:-$HOME/.config}/grip"
export FBOOKMARK_LOCATION="${XDG_CONFIG_HOME:-$HOME/.config}/fbookmark"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
export AWS_DEFAULT_REGION="ap-southeast-2"

if [[ ${OSTYPE} =~ "linux-gnu" ]] && [[ $(lsb_release -ds) =~ "Ubuntu" ]] 2>/dev/null; then
  export OS_DISTRO="UBUNTU"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ ${OSTYPE} =~ "darwin" ]]; then
  export OS_DISTRO="MACOS"
fi

# -- BMUX ----------------------------------------------------------------------

if [[ "${OS_DISTRO}" == "MACOS" ]]; then
  export BMUX_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/bmux/macos"
elif [[ "${OS_DISTRO}" == "UBUNTU" ]]; then
  export BMUX_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/bmux/ubuntu"
fi

export BMUX_ACTIVE_SYMBOL=""
export BMUX_INACTIVE_SYMBOL=""
export BMUX_ACTIVE_COLOR="32"

export BMUX_3_WEB='05c6,210x63,0,0{150x63,0,0,56,59x63,151,0[59x31,151,0,57,59x31,151,32,58]}'
export BMUX_3_VS='3807,210x63,0,0[210x45,0,0,1,210x17,0,46{105x17,0,46,3,104x17,106,46,4}]'
export BMUX_CODE='578a,239x62,0,0[239x45,0,0,30,239x16,0,46,31]'

# -- DUMP ----------------------------------------------------------------------

export DUMP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/dump/trash"
export DUMP_LOG="${XDG_DATA_HOME:-$HOME/.local/share}/dump/log"

# -- LESS ----------------------------------------------------------------------

export LESSHISTFILE=-
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# -- DOTBARE -------------------------------------------------------------------

export DOTBARE_DIR="$HOME/.cfg/"
export DOTBARE_TREE="$HOME"
export DOTBARE_BACKUP="${XDG_DATA_HOME:-$HOME/.local/share}/dotbare"
export DOTBARE_PREVIEW="cat {}"
export DOTBARE_FZF_DEFAULT_OPTS="--preview-window=right:65%"
export DOTBARE_KEY="
  --bind=alt-a:toggle-all
  --bind=alt-w:jump
  --bind=alt-0:top
  --bind=alt-s:toggle-sort
  --bind=alt-t:toggle-preview
  --bind=alt-j:preview-down
  --bind=alt-k:preview-up
"

# -- FZF ----------------------------------------------------------------------

_gen_fzf_default_opts() {
local color00='#282c34'
local color01='#353b45'
local color02='#3e4451'
local color03='#545862'
local color04='#565c64'
local color05='#abb2bf'
local color06='#b6bdca'
local color07='#c8ccd4'
local color08='#e06c75'
local color09='#d19a66'
local color0A='#e5c07b'
local color0B='#98c379'
local color0C='#56b6c2'
local color0D='#61afef'
local color0E='#c678dd'
local color0F='#be5046'

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
" --color=bg+:$color00,bg:$color00,spinner:$color0C,hl:$color0D"\
" --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C"\
" --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"\
" --height 100% --layout=reverse --border --cycle --info=inline"
}

_gen_fzf_default_opts

export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_ALT_C_COMMAND="fd --type d"
export FZF_ALT_C_OPTS="--preview 'tree -L 1 -C --dirsfirst {} | head -200'"

# Use fd to generate auto completion
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# activate fzf keybindings
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh
export FZF_COMPLETION_TRIGGER=''
export FZF_PREVIEW_COMMAND='cat {}'

# -- FUNCTIONS -----------------------------------------------------------------

take () {
  mkdir -p $@ && cd ${@:$#}
}

_run_fm() {
  fm
  BUFFER=
  zle accept-line
}

_run_ffd_d() {
  local result
  result="$(ffd --hidden --dir)"
  [[ -d "${result}" ]] && \
    cd "${result}"
  BUFFER=
  zle accept-line
}

# -- KEYBINDING ----------------------------------------------------------------

bindkey -v

# ci", ci', ci`, di", etc
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# ci{, ci(, ci<, di{, etc
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^o' accept-and-infer-next-history

bindkey "^p" up-line-or-history
bindkey "^n" down-line-or-history

bindkey -M vicmd v edit-command-line
bindkey "^?" backward-delete-char

bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion

zle -N fm-invoke _run_fm
bindkey "^g" fm-invoke

zle -N ffd-d-invoke _run_ffd_d
bindkey "\ed" ffd-d-invoke

# -- FINAL ---------------------------------------------------------------------

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

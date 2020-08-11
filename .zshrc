# -- Required first ------------------------------------------------------------

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -- Zinit installer -----------------------------------------------------------

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

# -- Plugins -------------------------------------------------------------------

zinit ice depth=1;
zinit light romkatv/powerlevel10k

zinit wait lucid light-mode for \
  ver="dev" \
    kazhala/dotbare \
  kazhala/bmux \
  kazhala/dump-cli \
  trigger-load'!fm;!mark' \
    https://github.com/kazhala/scripts/blob/master/shell/fbookmark \
  atload'bindkey -M vicmd "k" history-substring-search-up;
  bindkey -M vicmd "j" history-substring-search-down' \
    zsh-users/zsh-history-substring-search \
  atload'_zsh_autosuggest_start;
  bindkey -v "^ " autosuggest-accept' \
    zsh-users/zsh-autosuggestions \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay; _dotbare_completion_cmd dotbare" \
  atload"FAST_HIGHLIGHT[chroma-man]=" \
    zdharma/fast-syntax-highlighting

# -- Settings -----------------------------------------------------------------

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

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/Programming/scripts/shell:$PATH

# -- System ENV ----------------------------------------------------------------

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export EDITOR=nvim
export TERM="xterm-256color"
export COLORTERM="truecolor"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# -- Misc ENV ------------------------------------------------------------------

export GRIPHOME="${XDG_CONFIG_HOME:-$HOME/.config}/grip"
export FBOOKMARK_LOCATION="${XDG_CONFIG_HOME:-$HOME/.config}/fbookmark"

# -- bmux ----------------------------------------------------------------------

export BMUX_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/bmux"
export BMUX_3_WEB='05c6,210x63,0,0{150x63,0,0,56,59x63,151,0[59x31,151,0,57,59x31,151,32,58]}'
export BMUX_3_VS='f3ed,210x63,0,0[210x41,0,0,60,210x21,0,42{105x21,0,42,61,104x21,106,42,62}]'

# -- dump-cli ----------------------------------------------------------------------

export DUMP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/dump/trash"
export DUMP_LOG="${XDG_DATA_HOME:-$HOME/.local/share}/dump/log"
export DUMP_CONFIRM="y"

# -- less ----------------------------------------------------------------------

export LESSHISTFILE=-
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# -- dotbare -------------------------------------------------------------------

export DOTBARE_DIR="$HOME/.cfg/"
export DOTBARE_TREE="$HOME"
export DOTBARE_BACKUP="${XDG_DATA_HOME:-$HOME/.local/share}/dotbare"
export DOTBARE_PREVIEW="cat {}"
export DOTBARE_FZF_DEFAULT_OPTS="--preview-window=right:65%"

# -- fzf ----------------------------------------------------------------------

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:-1,hl+:#c678dd
--color=info:#98c379,prompt:#61afef,pointer:#e06c75,marker:#e5c07b,spinner:#61afef,header:#61afef
--height 100% --layout=reverse --border --cycle
'

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_ALT_C_COMMAND="fd --type d"
export FZF_ALT_C_OPTS="--preview 'tree -L 1 -C --dirsfirst {} | head -200'"

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# source the fzf keybindings script
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# overrite the tab behavior after sourcing the fzf.zsh script
export FZF_COMPLETION_TRIGGER=''
export FZF_PREVIEW_COMMAND='cat {}'

# -- Aliases -------------------------------------------------------------------

alias vim="nvim"
alias vimf="nvim '+Startify | FloatermNew vifm'"
alias py3="python3"
alias tree="tree -I '.git|node_modules|bower_components|.DS_Store|build'"
alias ag='ag -p ~/.ignore'
alias lg='lazygit'
alias ll='lsd -lAF --group-dirs first'
alias ls='lsd'
alias ..='cd ..'
alias mv='mv -v'
alias cp='cp -v'
alias rm='rm -v'
alias grep='grep --color=auto'
alias fs='bmux'

# -- Functions -----------------------------------------------------------------

take () {
  mkdir -p $@ && cd ${@:$#}
}

# -- Keybinding ----------------------------------------------------------------

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

# create keymaps without messing with zle
bindkey -s '^g' fm^j
bindkey -s '^d' "dotbare fedit"^j

# -- Required last -------------------------------------------------------------

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

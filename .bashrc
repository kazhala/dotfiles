# -- System Default ------------------------------------------------------------

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# -- Alias ---------------------------------------------------------------------

alias bashrc="vim ~/.bashrc"
alias ll="ls -alt"
alias vimrc="vim ~/.vimrc"
alias bashUpdate="source ~/.bashrc"
alias ..="cd .."

# -- PATH -----------------------------------------------------------------------

export NVM_DIR="$HOME/.nvm"

# -- Prompt --------------------------------------------------------------------

# check if the directory is dirty
propmt_dirt() {
	local s='';
	git rev-parse --is-inside-work-tree &>/dev/null || return;
	# Early exit for Chromium & Blink repo, as the dirty check takes too long.
	# Thanks, @paulirish!
	# https://github.com/paulirish/dotfiles/blob/dd33151f/.bash_prompt#L110-L123
	repoUrl="$(git config --get remote.origin.url)";
	if grep -q 'chromium/src.git' <<< "${repoUrl}"; then
		s+='*';
	else
		# Check for uncommitted changes in the index.
		if ! $(git diff --quiet --ignore-submodules --cached); then
			s+='+';
		fi;
		# Check for unstaged changes.
		if ! $(git diff-files --quiet --ignore-submodules --); then
			s+='!';
		fi;
		# Check for untracked files.
		if [ -n "$(git ls-files --others --exclude-standard)" ]; then
			s+='?';
		fi;
		# Check for stashed files.
		if $(git rev-parse --verify refs/stash &>/dev/null); then
			s+='$';
		fi;
	fi;
	[ -n "${s}" ] && s="[${s}]";
  echo -e "${s}";
}

# check if the directory contains git then check the branch
prompt_git() {
	local branchName='';
	# Check if the current directory is in a Git repository.
	git rev-parse --is-inside-work-tree &>/dev/null || return;
	# Check for what branch we’re on.
	# Get the short symbolic ref. If HEAD isn’t a symbolic ref, get a
	# tracking remote branch or tag. Otherwise, get the
	# short SHA for the latest commit, or give up.
	branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
		git describe --all --exact-match HEAD 2> /dev/null || \
		git rev-parse --short HEAD 2> /dev/null || \
		echo '(unknown)')";
  echo -e "(${branchName}";
}

# append the last parentheisis at the back of git branch status
prompt_closingBracket() {
	git rev-parse --is-inside-work-tree &>/dev/null || return;
  echo -e ")";
}

# call git check
git_branch() {
        prompt_git | sed 's/()//'
}

# bash propmt
PS1='\[\e[m\]'  # clear all colors
PS1+='\[\e[32m\]\u'   # username green
PS1+='\[\e[35m\]@'  # @ purple
PS1+='\[\e[34m\]\h'   # : blue
PS1+='\[\e[m\]:'  # white
PS1+='\[\e[36m\]\w'   # working dir cyan
PS1+='\[\e[33m\]$(git_branch)'  # git branch brown
PS1+='\[\e[31m\]$(propmt_dirt)'   # git status red
PS1+='\[\e[33m\]$(prompt_closingBracket)\n'   # git closing bracket brown
PS1+='\[\e[32m\]└─>' # next line indicator green
PS1+='\[\e[m\] ' # end of prompt clear the color

# -- Finalize ------------------------------------------------------------------

echo "Updated"

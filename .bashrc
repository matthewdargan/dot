eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(fzf --bash)"
[[ -r "$HOMEBREW_PREFIX/etc/bash_completion.d/git-completion.bash" ]] && source "$HOMEBREW_PREFIX/etc/bash_completion.d/git-completion.bash"
[[ -r "$HOMEBREW_PREFIX/etc/bash_completion.d/git-prompt.sh" ]] && source "$HOMEBREW_PREFIX/etc/bash_completion.d/git-prompt.sh"
export EDITOR=nvim
export VISUAL="$EDITOR"
export PS1='\[\e[1;33m\]\u\[\e[38;5;246m\]:\[\e[1;36m\]\w$(__git_ps1 "\[\e[38;5;246m\](\[\e[1;35m\]%s\[\e[38;5;246m\])")\[\e[1;32m\]$\[\e[0m\] '
alias vi='nvim'

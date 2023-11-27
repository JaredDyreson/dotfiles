export ZSH="/usr/share/oh-my-zsh"
export PAGER="most"

alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'

## File Manipulation

alias sz="source ~/.zshrc"
alias zrc="nvim ~/.zshrc"
alias vrc="nvim ~/.nvimrc"
alias dc="cd"
alias rm='nocorrect rm' 

# ZSH Environment Variables

ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="true"

PATH=$PATH$(find "$HOME/scripts" -type d -not -path '*/\.*' -printf ":%p")
PATH="$PATH:/opt/google/chrome/chrome"

[[ -n "$SSH_CONNECTION" ]] && export EDITOR='nvim'

export VISUAL=nvim
export EDITOR="$VISUAL"

git config --global credential.helper 'cache --timeout=18000'

# Colors
default=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)
purple=$(tput setaf 5)
orange=$(tput setaf 9)

# Less colors for man pages
export PAGER=less
export LESS='--incsearch  --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=2 '
# Begin blinking
export LESS_TERMCAP_mb=$red
# Begin bold
export LESS_TERMCAP_md=$orange
# End mode
export LESS_TERMCAP_me=$default
# End standout-mode
export LESS_TERMCAP_se=$default
# Begin standout-mode - info box
export LESS_TERMCAP_so=$purple
# End underline
export LESS_TERMCAP_ue=$default
# Begin underline
export LESS_TERMCAP_us=$green

source $ZSH/oh-my-zsh.sh

# Aliases

alias ls='ls -v --color=auto'
alias sl="ls"
alias vi="nvim"
alias vim="nvim"

source /usr/share/oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source /usr/share/oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
unsetopt BEEP
setopt no_share_history
unsetopt share_history
export RUSTFLAGS="--remap-path-prefix $HOME=~"

# NO HISTORY SHARING, FUCKING ANNOYING
setopt no_share_history
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH="/home/jared/.oh-my-zsh"
alias ls='ls --color=auto'

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
 DISABLE_AUTO_TITLE="false"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git reminder)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nano'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Small repetitive commands
rm -r ~/.zcompdump*
git config --global credential.helper 'cache --timeout=3600'

# Exports
export PAGER="most"
export ZSH_THEME="common"
PATH=$PATH$(find "$HOME/scripts" -type d -not -path '*/\.*' -printf ":%p")

# Functions and aliases

alias ..="cd .."
alias clear_tasks="rm $HOME/.todo.sav"
alias sl="ls"
alias "source ~/.bashrc"="echo Nope"
alias conv="convertTextToPDF"
alias uptime="uptime -p"
alias upgrade="sudo apt-get update && sudo apt-get upgrade -y"
alias x="xdg-open . > /dev/null 2>&1 & disown"


# defined functions that would not fit in a simple alias command
prompt_context() {}

function mtpdf() {
	echo "File: $1"
	#filename="$1:t:r"
	#echo "Filename: $filename"
	# converting
	#pandoc "$1" --listings -H $HOME/Documents/latex_formatting/coding.tex --variable urlcolor=blue -o "$filename".pdf
}

function pmark() {
	# Pandoc to Laetx Workflow for MLA Style --> http://barbaratozier.com/pandoc-to-latex-workflow/
	# user submitted templates for Pandoc
	# https://github.com/jgm/pandoc/wiki/User-contributed-templates
	[[ -d exported ]] || mkdir exported
#	find . -type f -iname '*.pdf' -exec mv {} -t exported \;
	# find all documents in a given folder, pipe to one file and export to master document (documents should be in numeric order to improve accuracy(
	# find . -type f -iname '*.md' | while read line; do cat "$line" >> master; done; C=notes pmark master
	for element in "$@"; do
		var="$element:t:r"
		case "$C" in
			notes)
				pandoc "$element" --toc --from markdown --template notes --listings --variable urlcolor=blue -o exported/"$var".pdf 
				;;
			coding)
				pandoc "$element" --toc --listings -H ~/.pandoc/templates/coding.latex --variable urlcolor=blue -V fontsize=11pt -o exported/"$var"
				;;
			worksheet)
				pandoc "$element" -o exported/"$var" --from markdown --template notes --listings --variable urlcolor=blue
				;;
			essay)
				pandoc "$element" -o exported/"$var"

		esac
	done
}

function respring_iphone() {
	tcprelay -t 22:2222 &
	ssh root@localhost 'killall -9 SpringBoard'
	killall tcprealy
}

function collate_documents() {
    [[ -d $(git rev-parse --show-toplevel) ]] || cd "$(git rev-parse --show-toplevel)"
    [[ -d ./tmp ]] || mkdir ./tmp
    find . -type f -name '*.md' ! -name 'README.md' | while read file; do
        cp -ar "$file" tmp/
        file=$(basename "$file")
        cd tmp
	    pmark tmp/"$file"
        cd ..
    done
    cd tmp
    pdfunite resources/Master\ Document.pdf
    cd ..
    rm -rf tmp/
}

function install() {
	sudo apt-get install "$@" -y
}
function lgit() {
	# find all the git repos in a given home folder
	sudo find "$HOME" -type d -name '.git'
}

function bak_pref() {
	[[ -d ~/Documents/dotfiles ]] || exit
	cp -ar ~/.zshrc ~/Documents/dotfiles/zshrc
	cp -ar ~/.vimrc ~/Documents/dotfiles/vimrc
	cd ~/Documents/dotfiles
	git add *
	git commit -m "Automatic backup performed"
	git push origin master
}

function notes() {
	# this is a large and on going program I am writing to compile my notes
	DOC_COUNT=$(find . -type f -iname '*.md' | wc -l)
	# find all titles
	grep '^[^\#]*\#[^\#]*$' file.md
	# this will find the date given the format mm/dd/yyyy
	grep -Eio '[0-1][0-9]\/[0-3][0-9]\/[0-9]{4}' Westward\ Expansion\ and\ the\ Sectional\ Crisis.md
	# grep for pdf lisitngs, attempt to split the pdf into images and embed them into the markdown file

}
#alias cd="cd $@ && ls ."

function catenate_notes {
	[[ -d "$PWD"/assets ]] || mkdir "$PWD"/assets
	find . -type f -iname '*.md' | while read line; do 
		echo "$line" | sed 's/^\.\///g'
	done | sort | while read file; do
			 parent=$(dirname -- "./$file")
			 find "$parent" -type d -iname 'assets' -exec cp {}/* -t "$PWD"/assets \;
			 cat "$file"
		       done > Final.txt
}
alias new_essay="cp -ar ~/Documents/MLA_Template.tex ."

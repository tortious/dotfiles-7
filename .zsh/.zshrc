#############################
### ENVIRONMENT VARIABLES ###
#############################

export EDITOR=$MAIN_EDITOR
export VISUAL=$EDITOR
export LSCOLORS='exfxcxdxbxegedabagacad'
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
export HOMEBREW_NO_ANALYTICS=1
export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH
export PIP_REQUIRE_VIRTUALENV=true
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
export GREP_COLORS=auto
export GREP_COLOR=auto
export WORDCHARS='*?_[]~=&;!#$%^(){}'
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export NVM_DIR=$HOME/.nvm
export PATH=/usr/local/bin:$PATH
export PATH=./node_modules/.bin:$PATH
export PATH=$HOME/.bin:$PATH

#############################
### GENERAL CONFIGURATION ###
#############################

setopt no_beep
setopt interactive_comments

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent

setopt append_history
setopt inc_append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history

for index ({1..9}) alias "$index"="cd +${index}"; unset index

autoload -U compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ''
# case-insensitive, partial-word, and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

####################
### KEY BINDINGS ###
####################
bindkey -e

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^b' backward-char
bindkey '^f' forward-char
bindkey '\eb' backward-word
bindkey '\ef' forward-word
bindkey '^u' backward-kill-line
bindkey '^k' kill-line
bindkey '^d' delete-char
bindkey '\ew' backward-kill-word
bindkey '\ed' kill-word
bindkey '^r' history-incremental-search-backward

bindkey '^u' backward-kill-line
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search

autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

zle -N insert-last-command-output
bindkey '^x^l' insert-last-command-output

autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey '^[m' copy-earlier-word

zle -N expand-or-complete-with-waiting-dots
bindkey '^i' expand-or-complete-with-waiting-dots

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

zle -N fancy-ctrl-z;
bindkey '^z' fancy-ctrl-z

zle -N exit-shell
bindkey '^Sx' exit-shell

#################
### FUNCTIONS ###
#################

expand-or-complete-with-waiting-dots() {
  echo -n "\e[31m......\e[0m"
  zle expand-or-complete
  zle redisplay
}

insert-last-command-output() {
  LBUFFER+="$(eval $history[$((HISTCMD-1))])"
}

fancy-ctrl-z() {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}

exit-shell() {
  exit
}

clear-iterm() {
  printf '\e]50;ClearScrollback\a'
}

#############
### OTHER ###
#############

eval "$(rbenv init - --no-rehash)"
stty -ixon
if [ -z $TMUX ]; then; tmux-start; fi

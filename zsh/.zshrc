autoload -U promptinit; promptinit; 
autoload -U compinit bashcompinit
compinit
bashcompinit
zstyle ':completion:*' menu yes select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true

autoload -U select-word-style
select-word-style bash

setopt auto_cd
setopt HIST_IGNORE_SPACE
setopt interactive_comments
setopt inc_append_history
setopt share_history
setopt AUTO_PUSHD          
setopt PUSHD_IGNORE_DUPS    
setopt PUSHD_SILENT         

if [[ -t 0 && $- = *i* ]]
then
    stty -ixon
fi 

unset histchars

for index ({1..9}) alias "$index"="cd +${index}"; unset index

HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000

bindkey '^[.' insert-last-word
bindkey "^[[H" beginning-of-line # HOME
bindkey "^[[F" end-of-line # END
bindkey "^[OH" beginning-of-line # HOME
bindkey "^[OF" end-of-line # END
bindkey "^[[3~" delete-char # DEL
bindkey -M emacs '\e#' pound-insert # ALT+#
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward
bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

alias ll='ls -larth'
alias eZ="vim ~/.zshrc"
alias eI="vim ~/.config/i3/config"
alias eW="vim ~/.wezterm.lua"
alias eV="vim ~/.vimrc"
alias eS="vim ~/.config/starship.toml"
alias history="history 0"
alias etcher="usbimager"
alias ls='ls --color=auto'
alias cmp='~/scripts/chezmoi-add-all-and-push'



function rm
{
  /bin/rm $@ -I
}


alias serve="python -m http.server 8000"


source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=( end-of-line )
#ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=( end-of-line )
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


export EDITOR="vim"
export PROMPT_EOL_MARK=""





# ========================================================================== --
# ==                         TOOLS AND PROGRAMS                           == --
# ========================================================================== --
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

alias k="kubectl"

source <(kubectl completion zsh) 
source <(gopher-cli completion zsh) 

complete -C '/usr/bin/aws_completer' aws
source <(VmChamp --completion zsh)
source <(minikube completion zsh)

source <(kummy completion zsh)




eval "$(starship init zsh)"



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

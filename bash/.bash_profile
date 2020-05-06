alias ll='ls -al'
alias sourcekitsad='rm -rf ~/Library/Developer/Xcode/DerivedData'
alias refresh_bash_profile='source ~/.bash_profile'
alias clear='printf "\033c"'

export LC_ALL="en_US.UTF-8"
export CLICOLOR=1

## Powerline shell ##
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

export PATH="$PATH:/usr/local/bin"

export SSLKEYLOGFILE=~/.ssl-key.log

## NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

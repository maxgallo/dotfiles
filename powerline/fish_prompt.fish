# Powerline go
# https://github.com/justjanne/powerline-go
# - much faster than "powerline" or "powerline-shell"

function fish_prompt
    eval ~/bin/powerline-go -error $status -shell bare -hostname-only-if-ssh -modules "venv,host,ssh,cwd,perms,git,hg,jobs,exit,root"
end


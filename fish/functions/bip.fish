# https://github.com/SidOfc/dotfiles/blob/c3a39e017d2f991dd0428e0175b32bde7a607e60/config.fish#L106
function bip --description "Install brew plugins"
    set -l inst (brew search | eval "fzf $FZF_DEFAULT_OPTS -m --header='[brew:install]'")

    if not test (count $inst) = 0
        for prog in $inst
            brew install "$prog"
        end
    end
end

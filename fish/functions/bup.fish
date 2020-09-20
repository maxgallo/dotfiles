# https://github.com/SidOfc/dotfiles/blob/c3a39e017d2f991dd0428e0175b32bde7a607e60/config.fish#L106
function bup --description "Update brew plugins"
    set -l inst (brew leaves | eval "fzf $FZF_DEFAULT_OPTS -m --header='[brew:update]'")

    if not test (count $inst) = 0
        for prog in $inst
            brew upgrade "$prog"
        end
    end
end

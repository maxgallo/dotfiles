function agr --description "Search and replace in folder"
    ag --hidden -0 -l "$argv[1]" | xargs -0 sed -ri -e "s/$argv[1]/$argv[2]/g"
end

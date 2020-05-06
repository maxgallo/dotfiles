function clpr
    set changelog ( git branch-name | sed "s/\//_/" )
    set file ( ls CHANGELOG | grep "$changelog" | tail -1 )
    set message ( grep "  m:" "CHANGELOG/$file" | sed "s/  m: //" )
    set jira ( grep "  jira:" "CHANGELOG/$file" | sed "s/  jira: //" )
    set template ( cat ./.github/PULL_REQUEST_TEMPLATE.md | string collect || echo "- Describe changes" )
    set fullMessage ( echo -e "$jira: $message\n\n$template" | string collect)
    hub pull-request --browse -m "$fullMessage" --draft
end

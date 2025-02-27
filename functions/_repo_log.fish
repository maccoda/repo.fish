# Usage: Search across commits with fzf
# Can provide usual git log parameters to the initial call and will be used to initially filter the results
# The fuzzy search will only be performed on the author and commit messages
function _repo_log
    # FIXME: Replace this with expanded version
    git $_repo_log_cmd --color=always | fzf --preview 'git show --color=always --stat {1}' --ansi --no-sort -n 2.. \
        --bind "enter:execute(git show --color=always {1} | less -R)" \
        --bind "?:preview(git show {1})" \
        --header "? for expanded diff"
end

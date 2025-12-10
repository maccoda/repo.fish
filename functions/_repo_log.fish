# Usage: Search across commits with fzf
# Can provide usual git log parameters to the initial call and will be used to initially filter the results
# The fuzzy search will only be performed on the author and commit messages
function _repo_log
    # TODO: Have a toggle for changing the command to show relative or absolulte time
    set log_pretty --pretty='format:%C(yellow)%h%C(reset) %C(magenta)(%cs)%C(reset) %s %C(blue)<%an>%C(reset) %C(red)%d%C(reset)'
    git log $log_pretty --color=always | fzf --preview 'git show --color=always --stat {1}' --ansi --no-sort -n 2.. \
        --preview-window=up,70% --layout=reverse \
        --bind "enter:execute(git show --color=always {1} | less -R)" \
        --bind "?:preview(git show --color=always {1})" \
        --bind "ctrl-s:toggle-sort" \
        --header "? for expanded diff | C-s to toggle sort"
end

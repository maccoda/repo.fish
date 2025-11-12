function _repo_switch
    set repo_status (git status --porcelain --untracked-files=no)
    if test -n "$repo_status"
        read --prompt-str "Uncomitted changes found, stashing. Stash message: " --local message
        git stash --message "$message"
    end
    set git_branch_cmd "git branch --all --format='%(refname:short)'"
    set switch_log_cmd "git log --oneline --no-decorate --color=always"
    # TODO: It would be nice if you could change the filter to only include locals, then all
    set selection (eval $git_branch_cmd | fzf --height "~20" --preview-window="75%" --bind "ctrl-r:reload(git fetch --all --prune &> /dev/null && $git_branch_cmd)" --header "C-r to refresh" --preview "$switch_log_cmd {}")
    if test -z $selection
        return
    end
    if echo $selection | rg --only-matching origin >/dev/null
        echo "Checking out remote branch $selection locally"
        git co (echo $selection | sed s#origin/##)
    else
        git switch $selection
    end
end

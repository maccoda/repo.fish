function _repo_main
    set repo_status (git status --porcelain)
    if test -n "$repo_status"
        echo "Detected local changes, stashing all"
        git stash --include-untracked >/dev/null
    end

    set repo_status (git status --porcelain)
    if test -n "$repo_status"
        echo "ERROR: Seems to have merge conflicts, resolve first then try again"
        git status --short
        return 1
    end

    git switch main &>/dev/null; or git switch master &>/dev/null
    if test $status -ne 0
        echo "ERROR: Unknown main branch"
        git branch
        return 1
    end
    set main_branch (git branch --show-current)
    echo "Determined primary branch is $main_branch"

    _repo_spin --title "Pulling latest changes on $main_branch" -- git pull --prune --tags origin $main_branch
    if test -n "$repo_status"
        git stash pop >/dev/null
    end
    _repo_prune_branches --force --no-fetch
    git $_repo_log_cmd -10
end

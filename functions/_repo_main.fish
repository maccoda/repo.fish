function _repo_main
    argparse r/refresh -- $argv
    set primary_branch (git symbolic-ref refs/remotes/origin/HEAD | cut -d '/' -f4)

    # Refresh just updates the current main branch to origin's main branch position without changing branch
    if set -q _flag_r
        _repo_spin --title "Refreshing origin" -- git fetch origin $primary_branch:$primary_branch
        return
    end
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
    set log_pretty --pretty='format:%C(red)%h%C(reset) %C(yellow)%cs%C(reset) %s %C(cyan)[%an]%C(reset) %C(blue)%d%C(reset)'
    git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -10
end

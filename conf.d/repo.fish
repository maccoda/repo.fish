if ! set --query _repo_log_cmd
    set --global _repo_log_cmd log --pretty="format:%C(yellow)%h%C(reset) %C(blue)%<(15)%an%C(reset) %C(magenta)%cs%C(reset) %s %C(red)%d%C(reset)"
end

function _repo_install --on-event repo_install
    if ! which gh &>/dev/null
        set_color red --bold
        echo "No gh installed, functionality will be limited"
        set_color normal
    end
    if ! which fzf &>/dev/null
        set_color red --bold
        echo "No fzf installed, functionality will be limited"
        set_color normal
    end
end

if status is-interactive
    set -l kernel_type (uname)
    if test "$kernel_type" = "Darwin"
        fish_add_path /opt/homebrew/bin/
    end
    
    starship init fish | source
end

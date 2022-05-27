if status is-interactive
    set -l kernel_type (uname)
    if test "$kernel_type" = "Darwin"
        fish_add_path /opt/homebrew/bin/
    end
    
    set -x N_PREFIX ~/.local/

    fish_add_path ~/.cargo/bin/
    fish_add_path ~/.local/bin/

    starship init fish | source
end

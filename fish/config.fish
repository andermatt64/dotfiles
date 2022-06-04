if status is-interactive
  set -l kernel_type (uname)
  if test "$kernel_type" = "Darwin"
    fish_add_path /opt/homebrew/bin/
  end
    
  set -x N_PREFIX ~/.local/

  fish_add_path ~/.cargo/bin/
  fish_add_path ~/.local/bin/
    
  if type -q exa
    alias ls="exa"
  end

  if type -q bat
    alias cat="bat"
  end

  starship init fish | source
end

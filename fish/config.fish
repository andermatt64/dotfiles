if status is-interactive
  set -l kernel_type (uname)
  if test "$kernel_type" = "Darwin"
    fish_add_path /opt/homebrew/bin/
  end
    
  set -x N_PREFIX ~/.local/

  set -x EDITOR hx
  set -x VISUAL hx
  
  fish_add_path ~/.cargo/bin/
  fish_add_path ~/.local/bin/
  
  if type -q exa
    alias ls="exa"
  end

  if type -q bat
    alias cat="bat"
  end

  if test -f /opt/homebrew/opt/ruby/bin/ruby
    fish_add_path /opt/homebrew/opt/ruby/bin
    set -gx LDFLAGS "-L/opt/homebrew/opt/ruby/lib"
    set -gx CPPFLAGS "-I/opt/homebrew/opt/ruby/include"
    set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/ruby/lib/pkgconfig"
  end
  
  if test -f /opt/homebrew/Caskroom/miniforge/base/bin/conda
      eval /opt/homebrew/Caskroom/miniforge/base/bin/conda "shell.fish" "hook" $argv | source
  end

  starship init fish | source
end

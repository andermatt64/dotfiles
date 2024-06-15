{lib, pkgs, ...}: 
  let
    platform = "${{TPL:system}}";
    osName = {
      "aarch64-darwin" = "darwin";
      "x86_64-darwin" = "darwin";
      "aarch64-linux" = "linux";
      "x86_64-linux" = "linux";
    }."${platform}";

    darwinCfg = {
      files = {
        ".amethyst.yml".source = ./amethyst/amethyst.yml;
      };
      packages = [
        pkgs.nerdfonts
        pkgs.b612
      ];
    };
    linuxCfg = {
      files = {};
      packages = [
        pkgs.gnumake
      ];
    };
  in
  {
  home.username = "${{TPL:user}}";
  home.homeDirectory = "${{TPL:home}}";

  home.stateVersion = "23.11";
  home.sessionVariables = {};

  home.file = {
    ".config/wezterm/wezterm.lua".source = ./wezterm/config.lua;
    ".config/starship.toml".source = ./starship/config.toml;
  } 
    // (
      if osName == "darwin" then darwinCfg.files 
      else if osName == "linux" then linuxCfg.files
      else {}
    );

  home.packages = [
    pkgs.rustup
    pkgs.xq-xml
    pkgs.difftastic
    pkgs.dust
    pkgs.hexyl
    pkgs.sox
    pkgs.nil
    pkgs.pastel
    pkgs.procs
    pkgs.mdcat
    pkgs.tokei
    pkgs.ripsecrets
    pkgs.marksman
    pkgs.taplo
  ] 
    ++ (
      if osName == "darwin" then darwinCfg.packages
      else if osName == "linux" then linuxCfg.packages
      else []
    );
 
  programs.home-manager.enable = true;
  programs.direnv = {
    enable = true;

    nix-direnv.enable = true;
  };
  programs.helix = {
    enable = true;

    defaultEditor = true;
    settings = {
      theme = "dark_plus";
      editor = {
        line-number = "relative";
        cursorline = true;
        bufferline = "multiple";
        true-color = true;
        color-modes = true;
        indent-guides.render = true;
        cursor-shape.insert = "bar";
      };
    };
    languages = {
      language-server.pyright-lsp = {
        command = "pyright-langserver";
        args = ["--stdio"];
        config = ''
          {
            "python": {
              "analysis": {
                "autoSearchPaths": true,
                "diagnosticMode": "workspace",
                "useLibraryCodeForTypes": true
              }
            }
          }
        '';
      };
      language = [
        {
          name = "python";
          language-servers = ["pyright-lsp"];
          formatter = {
            command = "black";
            args = [
              "--quiet"    
              "-"
            ];
          };
          auto-format = false;
        }
        {
          name = "html";
          formatter = {
            command = "prettier";
            args = [
              "--parser" 
              "html"
            ];
          };
        }
        {
          name = "json";
          formatter = {
            command = "prettier";
            args = [
              "--parser" 
              "json"
            ];
          };
        }
        {
          name = "css";
          formatter = {
            command = "prettier";
            args = [
              "--parser" 
              "css"
            ];
          };
        }
        {
          name = "javascript";
          formatter = {
            command = "prettier";
            args = [
              "--parser" 
              "typescript"
            ];
          };
        }
        {
          name = "typescript";
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "typescript"
            ];
          };
        }
        {
          name = "tsx";
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "typescript"
            ];
          };
        }
      ];
    };
  };
  programs.fd = {
    enable = true;

    hidden = false;
    ignores = [
      ".git/"
      "node_modules/"
      "venv/"
    ];
  };
  programs.fish = {
    enable = true;

    plugins = [
      {
        name = "foreign-env";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-foreign-env";
          rev = "7f0cf099ae1e1e4ab38f46350ed6757d54471de7";
          sha256 = "4+k5rSoxkTtYFh/lEjhRkVYa2S4KEzJ/IJbyJl+rJjQ=";
        };
      }
    ];
    shellAliases = {
      cat = "bat";
    };
    interactiveShellInit = ''
      set -x EDITOR hx
      set -x VISUAL hx
      
      if test -d /opt/homebrew/bin
        fish_add_path /opt/homebrew/bin
      end

      if test -d ~/.cargo/bin
        fish_add_path ~/.cargo/bin
      end

      if test -d ~/.local/bin
        fish_add_path ~/.local/bin
      end
    '';
    shellInit = ''
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      end
    '';
  };
  programs.btop = {
    enable = true;

    settings = {
      color_theme = "onedark";
    };
  };
  programs.skim.enable = true;
  programs.zellij = {
    enable = true;

    settings = {
      theme = "catppuccin-macchiato";
      default_shell = "fish";
      pane_frames = false;
      keybinds = {
        pane = {
          bind = {
            _args = [ "b" ];
            Clear = {
              
            };
          };
        };
      };
    };
  };
  programs.bat = {
    enable = true;

    themes = {
      catppuccin = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          sha256 = "6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        };
        file = "Catppuccin-macchiato.tmTheme";
      };
    };
    config = {
      theme = "catppuccin";
    };
  };
  programs.eza = {
    enable = true;
    git = true;
    icons = true;
  };
  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs.jq.enable = true;
  programs.ripgrep.enable = true;
}

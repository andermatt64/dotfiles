{lib, pkgs, ...}: 
  let
    platform = "${{TPL:system}}";
    darwinCfg = if platform == "aarch64-darwin" || platform == "x86_64-darwin" then {
      files = {
        ".amethyst.yml".source = ./amethyst/amethyst.yml;
      };
      packages = [
        pkgs.nerdfonts
        pkgs.b612
      ];
    } else {
      files = {};
      packages = [];
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
  } // darwinCfg.files;

  home.packages = [
    pkgs.rustup
    pkgs.xq-xml
    pkgs.difftastic
    pkgs.dust
    pkgs.hexyl
    pkgs.sox
    pkgs.nil
    pkgs.pastel
    pkgs.mdcat
    pkgs.tokei
    pkgs.ripsecrets
    pkgs.xz
    pkgs.marksman
    pkgs.taplo
  ] ++ darwinCfg.packages;
 
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
  programs.nushell = {
    enable = true;

    envFile.text = ''
      $env.ENV_CONVERSIONS = {
        "PATH": {
          from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
          to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
        }
        "Path": {
          from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
          to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
        }
      };
    '';
    
    configFile.text = ''
      $env.config = {
        show_banner: false,
      };
    '';
    
    environmentVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };

    extraConfig = ''
      def nuopen [arg, --raw (-r)] { if $raw { open -r $arg } else { open $arg } }
      def fenv [cmd] {
        mut new_env = {};
  
        let cmdline = $"source ($cmd) && env -0";
        let raw_env = (bash -c $cmdline | encode utf8);
        let delims = ($raw_env | bytes index-of --all 0x[00]);

        mut prev_delim = 0;
        for delim in $delims {
          let row = ($raw_env | bytes at $prev_delim..$delim | decode utf8 | split column "=");

          $prev_delim = $delim + 1;

          let key = ($row | get column1 | first);
          mut val = ($row | get column2 | first);

          if $key in [_ SHLVL PWD PROMPT_MULTILINE_INDICATOR PROMPT_INDICATOR DIRS_POSITION LAST_EXIT_CODE] {
            continue;
          }

          if $key =~ '^BASH_.*$' or $key =~ '^NU_.*$' {
            continue;
          }

          if $key in $env.ENV_CONVERSIONS {
            $val = (do $env.ENV_CONVERSIONS.PATH.from_string $val);
          }
    
          if ($key not-in $env) or ($env | get $key) != $val {
            $new_env = ($new_env | insert $key $val);
          }
        }

        $new_env
      }

      if ('/opt/homebrew/bin' | path exists) {
        $env.PATH = ($env.PATH | prepend '/opt/homebrew/bin');
      }

      if ('~/.cargo/bin' | path exists) {
        $env.PATH = ($env.PATH | append `~/.cargo/bin`);
      }

      if ('~/.local/bin' | path exists) {
        $env.PATH = ($env.PATH | append '~/.local/bin');
      }

      if ('/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' | path exists) {
        fenv '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' | load-env;
      }
    '';

    shellAliases = {
      cat = "bat";
      open = "^open";
    };
  };
  programs.btop = {
    enable = true;

    settings = {
      color_theme = "onedark";
    };
  };
  programs.zellij = {
    enable = true;

    settings = {
      theme = "catppuccin-macchiato";
      default_shell = "nu";
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
    enableAliases = true;
  };
  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs.jq.enable = true;
  programs.ripgrep.enable = true;
}

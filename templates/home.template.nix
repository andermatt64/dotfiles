{system, pkgs, ...}: {
  home.username = "${{TPL:user}}";
  home.homeDirectory = "${{TPL:home}}";

  home.stateVersion = "23.11";

  home.file = {};
  home.sessionVariables = {};
  home.packages = [
    pkgs.xq-xml
    pkgs.hexyl
    pkgs.sox
    pkgs.nerdfonts
  ];
  
  programs.home-manager.enable = true;
  programs.helix = {
    enable = true;

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
    languages = {};
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
    '';
    shellInit = ''
      if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      end
    '';
  };
  programs.starship = {
    enable = true;

    settings = {
      battery.disabled = true;
    };
  };
  programs.btop = {
    enable = true;
  };
  programs.zellij = {
    enable = true;

    settings = {
      theme = "catppuccin-macchiato";
    };
  };
  programs.zoxide = {
    enable = true;
    
    enableFishIntegration = true;
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
      theme = "catpuccin";
    }
  };
  programs.eza = {
    enable = true;
    git = true;
    enableAliases = true;
  };
  programs.jq.enable = true;
  programs.ripgrep.enable = true;
}

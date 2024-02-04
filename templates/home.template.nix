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
      cd = "z";
    };
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

    enableFishIntegration = true;
  };
  programs.zoxide = {
    enable = true;
    
    enableFishIntegration = true;
  };
  programs.bat = {
    enable = true;
  };
  programs.eza = {
    enable = true;
    git = true;
    enableAliases = true;
  };
  programs.jq.enable = true;
  programs.ripgrep.enable = true;
}

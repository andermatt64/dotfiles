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

    plugins = [];
    shellAliases = {
      ls = "eza";
      cat = "bat";
      cd = "z";
    };
    shellInit = ''
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
  programs.jq.enable = true;
  programs.ripgrep.enable = true;
}

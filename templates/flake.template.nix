{
  description = "Home Manager Configuration Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, home-manager, ...}: {
    defaultPackage = home-manager.defaultPackage.${{TPL:system}};
    
    homeConfigurations =
      let
        pkgs = nixpkgs.legacyPackages.${{TPL:system}};
      in {
        ${{TPL:user}} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ ./home.nix ];
        };
      };
  };
}

{
  description = "Vstor NixOS flake";

  inputs = {
    
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    awww.url = "git+https://codeberg.org/LGFae/awww";
    dwrs.url = "github:Bircoder432/dwrs";
    dwrs.inputs.nixpkgs.follows = "nixpkgs";
    yamusic-tui-enhanced.url = "github:Bircoder432/yamusic-tui-enhanced";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      agenix,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        vstorpc = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./configuration.nix
            ./modules/boot.nix
            ./modules/network.nix
            ./modules/locale.nix
            ./modules/services.nix
            ./modules/packages.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.vstor = import ./home/home.nix;
            }
          ];
        };
      };
    };
}

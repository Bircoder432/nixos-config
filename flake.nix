{
  description = "Vstor NixOS flake";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    #nixpkgs.url = "github:NixOS/nixpkgs/d351d0653aeb";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixi.url = "path:/home/vstor/Projects/nixi"
    awww.url = "git+https://codeberg.org/LGFae/awww";
    osatui.url = "path:/home/vstor/Projects/osatui";
    rustormy.url = "path:/home/vstor/Projects/rustormy";
    dwrs.url = "github:Bircoder432/dwrs";
    dwrs.inputs.nixpkgs.follows = "nixpkgs";
    yamusic-tui-enhanced.url = "github:Bircoder432/yamusic-tui-enhanced";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
# NOT WORK      osatui,
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

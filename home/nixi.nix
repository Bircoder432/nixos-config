{ pkgs, inputs, ... }:

{
  imports = [ inputs.nixi.homeManagerModules.x86_64-linux.dwrs ];
  programs.nixi = {
    enable = true;
    package = inputs.nixi.package.${pkgs.system}.nixi;
    defaultList = "system";
    autoRebuild = false;
    packageLists = {
      system = ./nixi.packages;
    };
  };

}


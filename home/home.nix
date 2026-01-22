{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [

    ./waybar.nix
    ./helix.nix
    ./git.nix
    ./dwrs.nix
    ./packages.nix
    ./rustormy.nix
    ./osatui.nix

  ];
  home.username = "vstor";


  home.file.".config" = {
    source = ../dotfiles;
    recursive = true;
  };
  home.file.".config/fish" = {
    source = ../dotfiles/fish;
    recursive = true;
  };
  home.file.".local/PrismLauncher/themes/Wallust" = {
    source = ../prismlauncher/Wallust;
    recursive = true;
  };
  services.kdeconnect.enable = true;
  home.stateVersion = "25.11";
}

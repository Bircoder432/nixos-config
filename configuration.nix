{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./modules/hardware.nix
  ];

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  
  console = {
    font = "cyr-sun16";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System state version
  system.stateVersion = "25.11";
}

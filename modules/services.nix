# ~/nixos-flake/modules/services.nix
{ config, pkgs,lib, ... }:

let
  tuigreetBin = "${pkgs.tuigreet}/bin/tuigreet";
  tuigreetOpts = lib.concatStringsSep " " [
    "--time"
    "--user-menu"
    "--remember"
    "--remember-user-session"
    "--cmd niri-session"
  ];
in
{
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
  };
  #services.displayManager.ly.enable = true;
 services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      default_session = {
        command = "${tuigreetBin} ${tuigreetOpts}";
        user = "greeter";
      };
    };
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-gnome  xdg-desktop-portal-wlr ];
  xdg.portal.config.common.default = "gnome";
  virtualisation.docker.enable = true;
  services.flatpak.enable = true;
  programs.fish.enable = true;
  
  users.users.vstor = {
    isNormalUser = true;
    home = "/home/vstor";
    description = "Вадим Сторожилов";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };
  services.xray = {
    enable = true;
    settingsFile = "/home/vstor/.config/xray.json";
  };
}

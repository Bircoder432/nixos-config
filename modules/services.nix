# ~/nixos-flake/modules/services.nix
{ config, pkgs, ... }:

{
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  services.displayManager.ly.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-wlr ];
  xdg.portal.config.common.default = "gtk";
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

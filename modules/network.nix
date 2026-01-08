{ config, pkgs, ... }:

{
  networking.hostName = "vstorpc";
  networking.networkmanager.enable = true;
}

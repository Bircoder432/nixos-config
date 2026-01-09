{ pkgs, inputs, ... }:

{
  imports = [ inputs.dwrs.homeManagerModules.dwrs ];

  programs.dwrs.enable = true;
  programs.dwrs.package = inputs.dwrs.packages.${pkgs.system}.dwrs;
  programs.dwrs.settings = {
    workers = 3;
    bar_chars = "=>-";
    template = "{spinner:.green} [{bar:30.cyan/blue}] {pos}/{len} ({percent}%) {msg}";
  };
}

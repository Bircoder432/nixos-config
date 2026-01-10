{ pkgs, inputs, ... }:

{
  imports = [ inputs.dwrs.homeManagerModules.x86_64-linux.dwrs ];

  programs.dwrs.enable = true;
  programs.dwrs.package = inputs.dwrs.packages.${pkgs.system}.dwrs;
  programs.dwrs.settings = {
    msg_template = "{download:green,bold} {url:yellow,bold} → {output:yellow,bold}";
    workers = 3;
    bar_chars = "=>-";
    template = "{spinner:.green} [{bar:30.cyan/blue}] {pos}/{len} ({percent}%) {msg}";
  };
}

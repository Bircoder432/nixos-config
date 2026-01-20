{ pkgs, inputs, ... }:

{
  imports = [
    (inputs.rustormy.homeManagerModules.x86_64-linux.rustormy)
  ];

  programs.rustormy = {
    enable = true;
    package = inputs.rustormy.packages.x86_64-linux.default;
    settings = {
      city = "Tyumen";
    };
  };
}

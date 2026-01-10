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
    ./yamusic-tui-enhanced.nix
  ];
  home.username = "vstor";
  
  home.packages = with pkgs; [
    agenix-cli
    fastfetch
    fish
    rustup
    zig
    gcc
    nodejs_24
    bun
    vue-language-server
    typescript-language-server
    typescript
    tree
    fd
    zed-editor
    helix
    musicpod
    tmux
    bitwarden-desktop
    telegram-desktop
    nil
    nixd
    termusic
    obs-studio
    prismlauncher
    luanti
    xonotic
    btop
    mindustry
    yazi
    jq
    file-roller
    zip
    unzip
    p7zip
    oreo-cursors-plus
    zrythm
    typst
    evans
    wev
    go
    onlyoffice-desktopeditors
  ];
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

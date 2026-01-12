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
    ./osatui.nix
    # NOT WORKED   ./yamusic-tui-enhanced.nix
  ];
  home.username = "vstor";

  home.packages = with pkgs; [
    agenix-cli
    fastfetch
    fish
    pandoc
    rustup
    zig
    gcc
    nodejs_24
    bun
    #    logseq
    vue-language-server
    typescript-language-server
    typescript
    libresprite
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
    (pkgs.writeShellScriptBin "lessons" ''
      #!/usr/bin/env bash

      GROUP_ID=161
      API="https://api.thisishyum.ru/schedule_api/tyumen"

      ${pkgs.curl}/bin/curl -s "$API/groups/$GROUP_ID/schedules?day=today" |
      ${pkgs.jq}/bin/jq -r '
        if length == 0 then
          "Нет пар"
        else
          (
            .[0].lessons | min_by(.order) | .startTime | .[0:5]
          ) + "–" +
          (
            .[0].lessons | max_by(.order) | .endTime | .[0:5]
          )
        end
      '
    '')
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

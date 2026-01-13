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
  ];
  home.username = "vstor";

  home.packages = with pkgs; [
    fastfetch
    fish
    pandoc
    rustup
    trash-cli
    rmtrash
    zoxide
    bat
    ripgrep
    fzf
    dust
    zig
    gcc
    nodejs_24
    wf-recorder
    bun
    gradle
    gradle-completion
    kotlin-language-server
    kotlin
    zathura
    zed-editor
    logseq
    vue-language-server
    typescript-language-server
    typescript
    libresprite
    tree
    fd
    nmap
    helix
    musicpod
    tmux
    bitwarden-desktop
    telegram-desktop
    nil
    nixd
    termusic
    obs-studio
    obs-studio-plugins.obs-gstreamer
    obs-studio-plugins.obs-vkcapture
    obs-studio-plugins.wlrobs
    obs-studio-plugins.obs-vaapi
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

    (pkgs.writeShellScriptBin "screencast" ''
      #!/usr/bin/env bash

      PID_FILE="/tmp/wf-recorder.pid"
      OUTDIR="$HOME/Videos/screencasts"
      mkdir -p "$OUTDIR"
      FILENAME="cast_$(date +%Y%m%d_%H%M%S).mp4"

      if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
          # Остановить запись
          kill -SIGINT "$(cat "$PID_FILE")"
          rm -f "$PID_FILE"
          notify-send "Скринкаст завершен" "$FILENAME сохранен"
      else
          # Запустить запись
          wf-recorder -f "$OUTDIR/$FILENAME" -a &
          echo $! > "$PID_FILE"
          notify-send "Скринкаст запущен"
      fi
      '')

    (pkgs.writeShellScriptBin "screencast-status" ''
        #!/usr/bin/env bash

        PID_FILE="/tmp/wf-recorder.pid"

        if [ -f "$PID_FILE" ] && kill -0 $(cat $PID_FILE) 2>/dev/null; then
          echo "REC"
        else
          echo ""
        fi
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

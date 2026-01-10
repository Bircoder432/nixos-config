{ config, inputs, ... }:

{
  imports = [ inputs.yamusic-tui-enhanced.homeManagerModules.x86_64-linux.yamusic-tui-enhanced];
  programs.yamusic-tui-enhanced.enable = true;
  programs.yamusic-tui-enhanced.settings = {
    token = "";
    buffer-size-ms = 80;
    rewind-duration-s = 5;
    volume = 0.5;
    volume-step = 0.05;
    show-errors = false;
    show-lyrics = false;
    cache-tracks = "likes";

    search = {
      artists = true;
      albums = false;
      playlists = false;
    };

    controls = {
      quit = "ctrl+q,ctrl+c";
      apply = "enter";
      cancel = "esc";
      cursor-up = "up";
      cursor-down = "down";
      show-all-keys = "?";
      playlists-up = "ctrl+up";
      playlists-down = "ctrl+down";
      playlists-rename = "ctrl+r";
      tracks-like = "l";
      tracks-add-to-playlist = "a";
      tracks-remove-from-playlist = "ctrl+a";
      tracks-share = "ctrl+s";
      tracks-shuffle = "ctrl+x";
      tracks-search = "ctrl+f";
      player-pause = "space";
      player-next = "right";
      player-previous = "left";
      player-rewind-forward = "ctrl+right";
      player-rewind-backward = "ctrl+left";
      player-like = "L";
      player-cache = "S";
      player-vol-up = "+,=";
      player-vol-down = "-";
    };
  };
}

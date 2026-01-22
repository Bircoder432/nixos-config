# ~/nixos-flake/modules/packages.nix
{
  config,
  pkgs,
  inputs,
  ...
}:

{
  programs.waybar.enable = true;
  programs.niri.enable = true;
  programs.kdeconnect.enable = true;
  environment.systemPackages = with pkgs; [
    wget
    git
#    tuigreet
    regreet
    greetd
    vulkan-tools
    firefox
    fuzzel
    alacritty
    pipewire
    steam
    pipewire.jack
    pavucontrol
    mako
    gnome-keyring
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    kdePackages.polkit-kde-agent-1
    xwayland-satellite
    playerctl
    wallust
    libnotify
    cava
    nemo
    nwg-look
    papirus-icon-theme
    papirus-folders
    rust-analyzer
    pkg-config
    openssl
    transmission_4-gtk
    transmission_4
    docker
    docker-compose
    mpv
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    corefonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    nerd-fonts.noto
    nerd-fonts.hack
    nerd-fonts.iosevka
    iosevka
    font-awesome
    jetbrains-mono
    fira-code

  ];

  environment.variables.EDITOR = "helix";
}

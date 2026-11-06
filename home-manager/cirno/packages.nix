{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [

    # misc
    vesktop
    firefox
    btop
    pipewire
    p7zip
    thunar
    blueman
    filezilla
    qbittorrent
    vlc
    peazip
    orca-slicer
    obs-studio
    alcom
    unityhub

    # games
    osu-lazer-bin
    prismlauncher
    oversteer
    slimevr
    wayvr

    #neovim packages
    stylua
    shfmt
    gofumpt
    yamlfmt
    rustfmt
    nixfmt
    clang-tools

    # terminal
    fastfetch
    ghostty
    neovim
    git
    putty
    pywal16
    pywalfox-native
  ];
}

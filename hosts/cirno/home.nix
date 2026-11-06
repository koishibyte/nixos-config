{ config, pkgs, ... }:

{

  imports = [
    ../../home-manager/cirno/default.nix

  ];

  home.username = "cirno";
  home.homeDirectory = "/home/cirno";
  home.stateVersion = "26.05";
}

{ config, ... }:

{
  services.mako = {
    enable = true;
    settings = {
      # got all these commands from https://man.archlinux.org/man/mako.5.en

      max-history = 0;
      max-visible = 1;

      default-timeout = 3000;
      ignore-timeout = 1;

      # making it pretty
      background-color = "#1f150d";
      border-color = "#B47646";
      progress-color = "#B48D41";
      padding = 10;
      width = 325;
      margin = 10;
      font = "Fire Code 10";
    };
  };
}

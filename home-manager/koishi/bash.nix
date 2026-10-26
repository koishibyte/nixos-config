{ config, pkgs, ... }:

{

  programs.bash = {
    enable = true;
    shellAliases = {
      ncgk = "sudo nix-collect-garbage -d";
      nrsk = "sudo nixos-rebuild switch --flake .#nixstrogen";
    };
    initExtra = ''
      fastfetch
      wal -R >/dev/null 2>&1
      export PS1="\w> "
    '';
  };
}

{ config, lib, pkgs, inputs, ... }: {
  imports = [
    ./hardware/bluetooth.nix
    ./hardware/nvidia.nix 
    ./services/default.nix
   ./networking/default.nix
  ];
}

{ config, pkgs, ... }:

{
   networking.firewall.enable = true;
   networking.firewall.allowedUDPPorts = [6969 9757 5353];
   networking.firewall.allowedTCPPorts = [9757 5353];
}


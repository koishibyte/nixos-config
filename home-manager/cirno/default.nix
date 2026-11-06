{
  config,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./plasma-config.nix
    ./packages.nix
  ];
}

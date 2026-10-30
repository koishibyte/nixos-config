{
  config,
  pkgs,
  agenix,
  ...
}:

{
  imports = [
    ../../modules/hardware/openlinkhub.nix
    ../../modules/gaming
    ../../modules/default.nix
    ./hardware-configuration.nix
  ];

  # Nvidia and openrgb
  hardware.nvidia.enable = true;
  services.hardware.openrgb.enable = true;

  # NordVPN configuration
  custom.services.nordvpn.enable = true;
  users.groups.nordvpn.members = [ "cirno" ];

  cirno.gaming = {
    enable = true;

    steam.enable = true;
    proton.enable = true;
    slippi.enable = true;
    dolphinemu.enable = true;
  };

  #VR gaming
  services.wivrn = {
    enable = true;
    openFirewall = true;
  };

  chimera.cooling.OpenLinkHub = {
    enable = true;
    package = pkgs.openlinkhub;
    config = ../../config/openlinkhub-config.json;
  };

  #udev rules for oversteer and slimevr
  services.udev.packages = with pkgs; [
    oversteer
    slimevr
  ];

  #pnpm package for slimevr
  nixpkgs.config.permittedInsecurePackages = [ "pnpm-9.15.9" ];

  #rcm stuff for nintendo switch
  services.nswitch-rcm = {
    enable = true;
    package = (
      pkgs.fetchurl {
        url = "https://github.com/CTCaer/hekate/releases/download/v6.5.4/hekate_ctcaer_6.5.4.bin";
        hash = "sha256-lfbpM+MuAo866Q8LCFf/R4AOg0vazjigqwGdjtNajCQ=";

      }
    );
  };

  #swap file
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16 GiB
    }
  ];

  networking.hostName = "blahaj";

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  #Plasma 6
  services.desktopManager.plasma6.enable = true;

  # SDDM (wayland)
  services.displayManager.sddm = {
    enable = true;

    wayland = {
      enable = true;
    };
  };

  #For gtk
  programs.dconf.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."cirno" = {
    isNormalUser = true;
    description = "";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      kdePackages.kate
      openrgb-with-all-plugins
      #cisco-packet-tracer_9 (setup once machine is setup)
    ];
  };

  services.blueman.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.jetbrains-mono
    font-awesome
    jetbrains-mono
  ];

  age.identityPaths = [ "/home/cirno/.ssh/id_ed25519" ];

  system.stateVersion = "26.05"; # Did you read the comment?

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

}

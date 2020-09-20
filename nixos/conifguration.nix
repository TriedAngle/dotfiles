# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  networking.hostName = "spc"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Allow unfree
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    # System
    wget
    htop
    unzip 
    ripgrep
    docker
    tmux
    curl
    openssl
    psmisc

    # Shell
    alacritty
    fish
    neofetch
    git
    direnv
    lorri
    niv
   
    # Desktop
    # polybar <-- switch to this in the future?
    dmenu
    feh
    picom
    haskellPackages.xmobar
    haskellPackages.xmonad
    haskellPackages.xmonad-extras
    haskellPackages.xmonad-contrib

    # Development
    nano
    neovim
    emacs
    vscode
    gitkraken
    jetbrains.jdk
    jetbrains.clion
    jetbrains.goland
    jetbrains.idea-ultimate    

    # Programming Languages / sdks
    rustup
    rustc
    cargo
    cargo-generate
    cargo-expand
    go
    jdk
    dotnet-sdk
    gradle
    
    # Applications
    chromium
    firefox
    libreoffice
    discord
    teamspeak_client
    eagle

    # Latex
    pandoc
    calibre
    texlive.combined.scheme-medium
    
    # Games
    multimc
    steam
  ];
  
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      powerline-fonts
      fira-code
      fira-code-symbols
    ];
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable lorri
  # services.lorri.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";
  services.xserver.videoDrivers = [ "nvidia" ];

  # Enable xmonad and set default user
  services.xserver = {
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmobar
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
	haskellPackages.xmonad
      ];
    };
    displayManager.gdm.enable = true;
    displayManager.defaultSession = "none+xmonad";
    desktopManager.xterm.enable = false;
    wacom.enable = true;
  };


  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable Printing
  services.printing.enable = true;

  # Enable the Gnome Desktop Environment
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome3.enable = true;
  
  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  users.users.sebastian = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "audio" "video" "tty" "docker" "input" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}


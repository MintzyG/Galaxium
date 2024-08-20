{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  wsl = {
    enable = true;
    defaultUser = "nova";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    gh
    git
    home-manager
    nh
    nix-output-monitor
    nvd
    neovim
  ];

  fonts.packages = [ pkgs.nerdfonts ];

  users.users.nova = {
    isNormalUser = true;
    description = "Nova";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  time.timeZone = "America/Sao_Paulo";
  i18n = {
    defaultLocale = "pt_BR.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };
  };

  environment.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };

  console.keyMap = "br-abnt2";

  system.stateVersion = "24.05";
}

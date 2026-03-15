{ pkgs, inputs, ... }:

{
  programs.home-manager.enable = true;

  imports = [
    ../../shared/user/apps/mpd.nix
    ../../shared/user/development/git.nix
    ../../shared/user/development/go.nix
    ../../shared/user/development/lazygit.nix
    ../../shared/user/development/nvim.nix
    ../../shared/user/quickshell/quickshell.nix
    ../../shared/user/shell/fish.nix
    ../../shared/user/services/swww.nix
    ../../shared/user/services/swaync.nix
    ../../shared/user/shell/starship.nix
    ../../shared/user/utilities/btop.nix
    ../../shared/user/utilities/eza.nix
    ../../shared/user/utilities/ghostty.nix
    ../../shared/user/utilities/hyfetch.nix
    ../../shared/user/utilities/kitty.nix
    ../../shared/user/utilities/rofi.nix
    ../../shared/user/utilities/stylix.nix
    ../../shared/user/utilities/yazi.nix
    ../../shared/user/desktop/hyprland.nix
    ../../shared/user/desktop/hypridle.nix
    ../../shared/user/desktop/hyprlock.nix
    ../../shared/user/user/pfp.nix
  ];

  home = {
    stateVersion = "25.11";
    username = "sophia";
    homeDirectory = "/home/sophia/";
    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "zen";
      TERMINAL = "ghostty";
    };
    packages = with pkgs; [
      brightnessctl
      cloc
      inputs.quickshell.packages."x86_64-linux".default
      inputs.zen-browser.packages."x86_64-linux".default
      jq
      ngrok
      nodejs
      opencode
      pnpm
      prismlauncher
      spotify
      telegram-desktop
      tree
      vesktop
      whatsapp-electron
    ];
  };
}

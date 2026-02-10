{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "start-hyprland";
        user = "sophia";
      };
    };
  };

  # gtkgreet configuration (runs inside Hyprland)
  environment.etc."greetd/gtkgreet.conf".text = ''
    [general]
    layer-shell = true
  '';

  environment.etc."greetd/environments".text = ''
    hyprland
    fish
    bash
    startxfce4
  '';

  users.users.sophia = {
    extraGroups = [ "video" "input" ];
  };
}


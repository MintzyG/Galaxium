{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "start-hyprland";
        user = "greeter";
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
  '';

  users.users.sophia = {
    extraGroups = [ "video" "input" ];
  };
}


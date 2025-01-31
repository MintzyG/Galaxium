{
  programs.hyfetch = {
    enable = true;

    settings = {
      preset = "transfeminine";
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.56;
      color_align = {
        mode = "horizontal";
        custom_colors = [ ];
        fore_back = null;
      };
      backend = "neofetch";
      distro = null;
      pride_month_shown = [ ];
      pride_month_disable = true;

      # Force HyFetch to allow images
      force_image_backend = true;
    };
  };

  home.file.".config/neofetch/config.conf".text = ''
    print_info() {
    prin " \n \n ╭───────┤ $(color 5)${" NixOS"} $(color 15)├───────╮"
    info " " kernel
    info " " wm
    info " " shell
    info " " term
    info " " de
    info " " theme
    info " " packages # Changed to an alternative packages icon
    info " " cpu # Changed to a different CPU icon
    info " " gpu # Changed to a different GPU icon
    info "󰍛 " memory
    info "󰔛 " uptime
    prin " \n \n ╰─────────────────────────╯"
    prin " \n \n \n \n $(color 1) \n $(color 2) \n $(color 3) \n $(color 4) \n $(color 5) \n $(color 6) \n $(color 7) \n $(color 0)"
    }

    # Additional Info Toggles
    kernel_shorthand="on"
    uptime_shorthand="on"
    memory_percent="on"
    memory_unit="gib"
    package_managers="on"
    shell_path="off"
    shell_version="off"
    cpu_brand="on"
    cpu_speed="on"
    cpu_cores="on"
    cpu_temp="on"
    gpu_brand="on"
    gpu_type="all"
    gpu_driver="on"
    refresh_rate="off"
    colors=(distro)
    bold="off"
    separator=""

    # Packages from specific origins
    packages="on"
    package_managers="on"
    specific_package_sources="on"
    package_sources=( "community" "main" "AUR" )

    # Image Settings
    image_backend="kitty" # Changed to kitty for better image support
    image_source="$HOME/Pictures/pfp.png" # Ensure this is a direct image file
    image_size="200px" # auto 00px 00% none

    ascii_distro="NixOS" # Changed to big NixOS
    ascii_colors=(distro)
    ascii_bold="on"
    ascii_size="big" # This sets the ASCII art size to big

    # Image settings
    image_loop="true"
    crop_mode="normal" # normal fit fill
    crop_offset="center" # northwest north northeast west center east southwest south southeast
    gap=1 # num -num
  '';
}


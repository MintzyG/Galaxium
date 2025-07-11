{
  programs.btop = {
    enable = true;
    settings = {

      # General settings
      theme_background = true;
      show_help = true;
      update_rate = 1000;
      auto_launch = true;
      show_full_path = true;
      refresh_interval = 1000;

      # System information settings
      show_system_info = true;
      show_fps = true;
      show_uptime = true;
      show_load_average = true;
      show_swap = true;

      # CPU settings
      cpu_display = "full";
      show_cpu_usage = true;
      cpu_format = "usage";

      # Memory settings
      show_memory = true;
      memory_display = "usage";

      # Disk settings
      show_disk_usage = true;
      disk_display = "usage";

      # Network settings
      show_network = true;
      network_display = "speed";

      # Processes settings
      show_processes = true;
      processes_display = "top";
      process_sort = "cpu";

      # Graphics settings
      graph_width = 50;
      graph_height = 3;
      graph_color_mode = "default";
      graph_color = "blue";
    };
  };
}

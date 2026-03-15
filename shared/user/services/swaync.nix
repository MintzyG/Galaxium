{
  services.swaync = {
    enable = true;

    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      notification-window-width = 360;
      notification-inline-replies = false;
      notification-2fa-action = true;
      timeout = 0;
      timeout-low = 0;
      timeout-critical = 0;
      notification-icon-size = 32;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = true;
      hide-on-action = false;
      fit-to-screen = false;
      widgets = [ "notifications" ];
    };

    style = ''
      * {
        all: unset;
        outline: none !important;
        box-shadow: none !important;
        font-family: "JetBrainsMono Nerd Font Mono";
        font-size: 13px;
      }

      scrolledwindow,
      scrolledwindow * {
        border: none;
        outline: none;
        box-shadow: none;
      }

      .notification-row {
        outline: none;
        margin: 8px 8px 0 8px;
      }

      .notification {
        background: @theme_bg_color;
        border: none;
        border-radius: 16px;
        padding: 12px;
        min-width: 300px;
        max-width: 340px;
        max-height: 200px;
        overflow: hidden;
      }

      .notification-content {
        padding: 4px;
      }

      /* remove clicabilidade da notif inteira */
      .notification-default-action {
        border-radius: 16px;
        background: transparent;
      }

      .app-icon {
        min-width: 32px;
        min-height: 32px;
        margin-right: 8px;
      }

      .app-name {
        color: @theme_fg_color;
        font-weight: bold;
        font-size: 11px;
        opacity: 0.6;
      }

      .summary {
        color: @theme_fg_color;
        font-size: 13px;
        font-weight: bold;
      }

      .time {
        color: @theme_fg_color;
        font-size: 10px;
        opacity: 0.4;
        margin-left: 4px;
      }

      .body {
        color: @theme_fg_color;
        opacity: 0.8;
        font-size: 12px;
      }

      .close-button {
        background: @error_color;
        border-radius: 50%;
        color: white;
        opacity: 0.9;
        font-size: 11px;
        font-weight: bold;
        min-width: 18px;
        min-height: 18px;
        max-width: 18px;
        max-height: 18px;
        padding: 0;
        margin: 7px 7px 0 auto; /* 16 - 9 = 7px */
      }

      .close-button:hover {
        opacity: 1;
      }

      .body-image {
        border-radius: 8px;
        margin-top: 8px;
      }

      .notification-action {
        background: @theme_bg_color;
        border: 1px solid @borders;
        border-radius: 8px;
        color: @theme_fg_color;
        margin: 4px 2px 0;
        padding: 4px 10px;
        font-size: 12px;
      }

      .notification-action:hover {
        background: @theme_selected_bg_color;
        color: @theme_selected_fg_color;
      }

      progressbar {
        margin-top: 4px;
      }

      progressbar trough {
        background: @borders;
        border-radius: 4px;
        min-height: 2px;
      }

      progressbar progress {
        background: @theme_selected_bg_color;
        border-radius: 4px;
        min-height: 2px;
      }

      .critical {
        border-color: @error_color;
      }

      .low {
        opacity: 0.85;
      }
    '';
  };
}

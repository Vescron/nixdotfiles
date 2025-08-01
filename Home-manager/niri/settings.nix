{
  config,
  pkgs,
  ...
}: let
  pointer = config.home.pointerCursor;
  makeCommand = command: {
    command = [command];
  };
in {
  programs.niri = {
    enable = true;
    settings = {
      environment = {
        CLUTTER_BACKEND = "wayland";
        DISPLAY = ":0";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
      };
      spawn-at-startup = [
        # (makeCommand "hyprlock")
        # (makeCommand "swww-daemon")
        # {command = ["wl-paste" "--watch" "cliphist" "store"];}
        # {command = ["wl-paste" "--type text" "--watch" "cliphist" "store"];}
        { command = ["mako"]; }
      { command = ["waybar"]; }
      { command = ["swaybg" "--image" "/home/sibtain/Pictures/a_white_building_with_balconies.jpg"]; }
      { command = ["xwayland-satellite"]; }
      ];
      input = {
        keyboard.xkb.layout = "us";

        touchpad = {
          click-method = "button-areas";
          dwt = true;
          dwtp = true;
          natural-scroll = true;
          scroll-method = "two-finger";
          tap = true;
          tap-button-map = "left-right-middle";
          middle-emulation = true;
          accel-profile = "adaptive";
        };

        mouse = {
        accel-speed = 0.0;
        accel-profile = "adaptive";
        natural-scroll = false;
        left-handed = false;
        middle-emulation = false;
        scroll-method = "two-finger";
      };

        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "90%";
        };
        warp-mouse-to-focus.enable = true;
        workspace-auto-back-and-forth = true;
      };
      screenshot-path = "~/Pictures/Screenshots/Screenshot-from-%Y-%m-%d-%H-%M-%S.png";
      outputs = {
        "eDP-1" = {
        # enable = true;  # This option doesn't exist
        mode = { width = 1920; height = 1080; refresh = 60.0; };  # Changed from resolution/refresh-rate
        position = { x = 0; y = 0; };
        transform = {
          flipped = false;
          rotation = 0;
        };
        scale = 1.0;
      };
      };

      layer-rules = [
      {
        matches = [{ namespace = "^wallpaper$"; }];
        place-within-backdrop = true;
      }
    ];

      overview = {
        workspace-shadow.enable = true;
        # backdrop-color = "transparent";
      };
      gestures = {hot-corners.enable = true;};
      cursor = {
        size = 20;
        theme = "Bibata-Modern-Classic";
      };
      layout = {
        background-color = "transparent";
        focus-ring.enable = false;
        border = {
          enable = true;
          width = 4;
          active.color = "#fff9b5ff";
          inactive.color = "#61a7edff";
        };
        always-center-single-column = true;
        shadow = {
          enable = true;
        };
        preset-column-widths = [
          {proportion = 0.25;}
          {proportion = 0.5;}
          {proportion = 0.75;}
          {proportion = 1.0;}
        ];
        default-column-width = {proportion = 0.75;};

        gaps = 6;
        struts = {
          left = 0;
          right = 0;
          top = 0;
          bottom = 0;
        };

        tab-indicator = {
          hide-when-single-tab = true;
          place-within-column = true;
          position = "left";
          corner-radius = 20.0;
          gap = -12.0;
          gaps-between-tabs = 10.0;
          width = 4.0;
          length.total-proportion = 0.1;
        };
      };

      animations.window-resize.custom-shader = ''
        vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
          vec3 coords_next_geo = niri_curr_geo_to_next_geo * coords_curr_geo;

          vec3 coords_stretch = niri_geo_to_tex_next * coords_curr_geo;
          vec3 coords_crop = niri_geo_to_tex_next * coords_next_geo;

          // We can crop if the current window size is smaller than the next window
          // size. One way to tell is by comparing to 1.0 the X and Y scaling
          // coefficients in the current-to-next transformation matrix.
          bool can_crop_by_x = niri_curr_geo_to_next_geo[0][0] <= 1.0;
          bool can_crop_by_y = niri_curr_geo_to_next_geo[1][1] <= 1.0;

          vec3 coords = coords_stretch;
          if (can_crop_by_x)
              coords.x = coords_crop.x;
          if (can_crop_by_y)
              coords.y = coords_crop.y;

          vec4 color = texture2D(niri_tex_next, coords.st);

          // However, when we crop, we also want to crop out anything outside the
          // current geometry. This is because the area of the shader is unspecified
          // and usually bigger than the current geometry, so if we don't fill pixels
          // outside with transparency, the texture will leak out.
          //
          // When stretching, this is not an issue because the area outside will
          // correspond to client-side decoration shadows, which are already supposed
          // to be outside.
          if (can_crop_by_x && (coords_curr_geo.x < 0.0 || 1.0 < coords_curr_geo.x))
              color = vec4(0.0);
          if (can_crop_by_y && (coords_curr_geo.y < 0.0 || 1.0 < coords_curr_geo.y))
              color = vec4(0.0);

          return color;
        }
      '';
      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;
    };
  };
}

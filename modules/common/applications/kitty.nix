{ config, pkgs, lib, ... }: {

  options = {
    kitty = {
      enable = lib.mkEnableOption {
        description = "Enable Kitty.";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.gui.enable && config.kitty.enable) {

    home-manager.users.${config.user} = {

      programs.kitty = {
        enable = true;
        environment = { };
        extraConfig = "";
        font.size = 12;
        keybindings = {
          "kitty_mod+b" = "scroll_page_up";
          "kitty_mod+f" = "scroll_page_down";
          "kitty_mod+enter" = "new_window_with_cwd";
          "kitty_mod+h" = "previous_window";
          "kitty_mod+l" = "next_window";
          "kitty_mod+j" = "previous_tab";
          "kitty_mod+k" = "next_tab";
          "kitty_mod+t" = "new_tab_with_cwd";
          "kitty_mod+0" = "goto_layout tall";
          "kitty_mod+1" = "goto_layout horizontal";
          "kitty_mod+equal" = "change_font_size current +2.0";
          "kitty_mod+minus" = "change_font_size current -2.0";
          "kitty_mod+backspace" = "change_font_size current 0";
          "kitty_mod+c" = "copy_to_clipboard";
          "kitty_mod+v" = "paste_from_clipboard";
          "ctrl+alt+shift+n" = "launch kitty nu -li";
          "ctrl+alt+shift+b" = "launch kitty bash -li";
          "ctrl+k" = "clear_terminal reset active";
        };

        settings = {
          kitty_mod = "ctrl+shift";

          # Colors (adapted from: https://github.com/kdrag0n/base16-kitty/blob/master/templates/default-256.mustache)
          background = config.theme.colors.base00;
          foreground = config.theme.colors.base05;
          selection_background = config.theme.colors.base05;
          selection_foreground = config.theme.colors.base00;
          url_color = config.theme.colors.base04;
          cursor = config.theme.colors.base05;
          active_border_color = config.theme.colors.base03;
          inactive_border_color = config.theme.colors.base01;
          active_tab_background = config.theme.colors.base00;
          active_tab_foreground = config.theme.colors.base05;
          inactive_tab_background = config.theme.colors.base01;
          inactive_tab_foreground = config.theme.colors.base04;
          tab_bar_background = config.theme.colors.base01;

          # normal
          color0 = config.theme.colors.base00;
          color1 = config.theme.colors.base08;
          color2 = config.theme.colors.base0B;
          color3 = config.theme.colors.base0A;
          color4 = config.theme.colors.base0D;
          color5 = config.theme.colors.base0E;
          color6 = config.theme.colors.base0C;
          color7 = config.theme.colors.base05;

          # bright
          color8 = config.theme.colors.base03;
          color9 = config.theme.colors.base08;
          color10 = config.theme.colors.base0B;
          color11 = config.theme.colors.base0A;
          color12 = config.theme.colors.base0D;
          color13 = config.theme.colors.base0E;
          color14 = config.theme.colors.base0C;
          color15 = config.theme.colors.base07;

          # extended base16 colors
          color16 = config.theme.colors.base09;
          color17 = config.theme.colors.base0F;
          color18 = config.theme.colors.base01;
          color19 = config.theme.colors.base02;
          color20 = config.theme.colors.base04;
          color21 = config.theme.colors.base06;

          # Scrollback
          scrolling_lines = 10000;
          scrollback_pager_history_size = 10; # MB
          scrollback_pager = "${pkgs.neovim}/bin/nvim -c 'normal G'";

          # Window
          window_padding_width = 6;

          tab_bar_edge = "top";
          tab_bar_style = "slant";

          # Audio
          enable_audio_bell = false;
        };
      };
    };
  };
}

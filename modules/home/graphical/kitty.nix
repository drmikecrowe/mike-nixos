{ osConfig
, lib
, pkgs
, ...
}: {
  programs.kitty = lib.mkIf osConfig.gui.enable {
    enable = true;
    environment = { };
    extraConfig = "";
    font.size = 12;
    font.name = "FiraCode";
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
      background = osConfig.theme.colors.base00;
      foreground = osConfig.theme.colors.base05;
      selection_background = osConfig.theme.colors.base05;
      selection_foreground = osConfig.theme.colors.base00;
      url_color = osConfig.theme.colors.base04;
      cursor = osConfig.theme.colors.base05;
      active_border_color = osConfig.theme.colors.base03;
      inactive_border_color = osConfig.theme.colors.base01;
      active_tab_background = osConfig.theme.colors.base00;
      active_tab_foreground = osConfig.theme.colors.base05;
      inactive_tab_background = osConfig.theme.colors.base01;
      inactive_tab_foreground = osConfig.theme.colors.base04;
      tab_bar_background = osConfig.theme.colors.base01;

      # normal
      color0 = osConfig.theme.colors.base00;
      color1 = osConfig.theme.colors.base08;
      color2 = osConfig.theme.colors.base0B;
      color3 = osConfig.theme.colors.base0A;
      color4 = osConfig.theme.colors.base0D;
      color5 = osConfig.theme.colors.base0E;
      color6 = osConfig.theme.colors.base0C;
      color7 = osConfig.theme.colors.base05;

      # bright
      color8 = osConfig.theme.colors.base03;
      color9 = osConfig.theme.colors.base08;
      color10 = osConfig.theme.colors.base0B;
      color11 = osConfig.theme.colors.base0A;
      color12 = osConfig.theme.colors.base0D;
      color13 = osConfig.theme.colors.base0E;
      color14 = osConfig.theme.colors.base0C;
      color15 = osConfig.theme.colors.base07;

      # extended base16 colors
      color16 = osConfig.theme.colors.base09;
      color17 = osConfig.theme.colors.base0F;
      color18 = osConfig.theme.colors.base01;
      color19 = osConfig.theme.colors.base02;
      color20 = osConfig.theme.colors.base04;
      color21 = osConfig.theme.colors.base06;

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
}

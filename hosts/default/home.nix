{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "user";
  home.homeDirectory = "/home/user";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.gnomeExtensions.user-themes
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.freon
    pkgs.gnomeExtensions.just-perfection
    pkgs.gnomeExtensions.rounded-corners
    pkgs.gnomeExtensions.user-avatar-in-quick-settings
    pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.weather-or-not
    pkgs.gnomeExtensions.blur-my-shell
    pkgs.gnomeExtensions.nothing-to-say
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/kitty/kitty.conf".text = ''
      linux_display_server x11
      wayland_titlebar_color system
      font_family      RobotoMono
      bold_font        auto
      italic_font      auto
      bold_italic_font auto
      font_size 10.0
      background_blur 1
      background_opacity .8
      disable_ligatures never
      
      # no bells. Ever.
      enable_audio_bell no
      bell_on_tab no
      map ctrl+left resize_window narrower
      map ctrl+right resize_window wider
      map ctrl+up resize_window taller
      map ctrl+down resize_window shorter 3
      
      map ctrl+h neighboring_window left
      map ctrl+j neighboring_window down
      map ctrl+k neighboring_window up
      map ctrl+l neighboring_window right
      
      active_tab_title_template '{index}: {title}'
      map cmd+d new_window_with_cwd
      # don't draw extra borders, but fade the inactive text a bit
      inactive_border_color #2D293B
      active_border_color #3E4058
      inactive_text_alpha 0.6
      
      # tabbar should be at the top
      tab_bar_edge top
      tab_bar_style powerline 
      tab_separator " |"
      
      include dracula.conf
      '';
    ".config/kitty/dracula.conf".text = ''
      foreground            #f8f8f2
      background            #282a36
      selection_foreground  #ffffff
      selection_background  #44475a
      
      url_color #8be9fd
      
      # black
      color0  #21222c
      color8  #6272a4
      
      # red
      color1  #ff5555
      color9  #ff6e6e
      
      # green
      color2  #50fa7b
      color10 #69ff94
      
      # yellow
      color3  #f1fa8c
      color11 #ffffa5
      
      # blue
      color4  #bd93f9
      color12 #d6acff
      
      # magenta
      color5  #ff79c6
      color13 #ff92df
      
      # cyan
      color6  #8be9fd
      color14 #a4ffff
      
      # white
      color7  #f8f8f2
      color15 #ffffff
      
      # Cursor colors
      cursor            #f8f8f2
      cursor_text_color background
      
      # Tab bar colors
      active_tab_foreground   #282a36
      active_tab_background   #f8f8f2
      inactive_tab_foreground #282a36
      inactive_tab_background #6272a4
      
      # Marks
      mark1_foreground #282a36
      mark1_background #ff5555
      
      # Splits/Windows
      active_border_color #f8f8f2
      inactive_border_color #6272a4
      '';
      ".config/fish/config.fish".text = ''
        set fish_greeting
        set -gx EDITOR vim
        # Colorscheme: Dracula
        set -U fish_color_normal f8f8f2
        set -U fish_color_command 8be9fd
        set -U fish_color_quote f1fa8c
        set -U fish_color_redirection f8f8f2
        set -U fish_color_end ffb86c
        set -U fish_color_error ff5555
        set -U fish_color_param bd93f9
        set -U fish_color_comment 6272a4
        set -U fish_color_match --background=brblue
        set -U fish_color_selection --background=44475a
        set -U fish_color_search_match --background=44475a
        set -U fish_color_history_current --bold
        set -U fish_color_operator 50fa7b
        set -U fish_color_escape ff79c6
        set -U fish_color_cwd 50fa7b
        set -U fish_color_cwd_root red
        set -U fish_color_valid_path --underline
        set -U fish_color_autosuggestion 6272a4
        set -U fish_color_user 8be9fd
        set -U fish_color_host bd93f9
        set -U fish_color_cancel ff5555 --reverse
        set -U fish_pager_color_background 
        set -U fish_pager_color_prefix 8be9fd
        set -U fish_pager_color_progress 6272a4
        set -U fish_pager_color_completion f8f8f2
        set -U fish_pager_color_description 6272a4
        set -U fish_pager_color_selected_background --background=44475a
        set -U fish_pager_color_selected_prefix 8be9fd
        set -U fish_pager_color_selected_completion f8f8f2
        set -U fish_pager_color_selected_description 6272a4
        set -U fish_color_option 
        set -U fish_color_keyword 
        set -U fish_pager_color_secondary_background 
        set -U fish_pager_color_secondary_prefix 
        set -U fish_pager_color_secondary_description 
        set -U fish_color_host_remote 
        set -U fish_pager_color_secondary_completion 
        
        
        function fish_prompt
          if [ $status = 0 ]
            set_color green
            if git rev-parse 2> /dev/null
              echo -n (git rev-parse --abbrev-ref HEAD 2> /dev/null)
            else
              echo -n (hostname)
            end
          else
            set_color red
            if git rev-parse 2> /dev/null
              echo -n (git rev-parse --abbrev-ref HEAD)
            else
              echo -n (hostname) 
            end
          end
          set_color normal
          echo -n ' ('
          echo -n (prompt_pwd)
          echo -n ') '
        end
        
        function fish_title
            # this one sets the X terminal window title
            # argv[1] has the full command line
            echo (hostname): (prompt_pwd): $argv[1]
        
            switch "$TERM"
            case 'screen*'
        
              # prepend hostname to screen(1) title only if on ssh
              if set -q SSH_CLIENT
                set maybehost (hostname):
              else
                set maybehost ""
              end
        
              # inside the function fish_title(), we need to
              # force stdout to reach the terminal
              #
              # (status current-command) gives only the command name
              echo -ne "\\ek"$maybehost(status current-command)"\\e\\" > /dev/tty
            end
        end
      '';
        };
  home.sessionVariables = {
    EDITOR = "vim";
    TERMINAL = "kitty";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Use `dconf watch /` to track stateful changes you are doing, then set them here.
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "kitty.desktop"
        "org.gnome.Nautilus.desktop"
      ];
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "freon@UshakovVasilii_Github.yahoo.com"
        "dash-to-dock@micxgx.maildomain.com"
        "just-perfection-desktop@just-perfection"
        "Rounded_Corners@lennart-k"
        "quick-settings-avatar@d-go"
        "appindicatorsupport@rgcjonas.maildomain.com"
        "weatherornot@somepaulo.github.io"
        "blur-my-shell@aunetx"
        "nothing-to-say@extensions.gnome.wouter.bolsterl.ee"
      ];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}

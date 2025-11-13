{pkgs, ...}: {
  programs.fish = {
    enable = true;
    plugins = with pkgs.fishPlugins; [
      {
        name = "fzf-fish";
        src = fzf-fish.src;
      }
      {
        name = "grc";
        src = grc.src;
      }
      {
        name = "hydro";
        src = hydro.src;
      }
    ];
    interactiveShellInit = ''
      # Dracula Color Palette
      set -l foreground f8f8f2
      set -l selection 44475a
      set -l comment 6272a4
      set -l red ff5555
      set -l orange ffb86c
      set -l yellow f1fa8c
      set -l green 50fa7b
      set -l purple bd93f9
      set -l cyan 8be9fd
      set -l pink ff79c6

      # Syntax Highlighting Colors
      set -gx fish_color_normal $foreground
      set -gx fish_color_command $cyan
      set -gx fish_color_keyword $pink
      set -gx fish_color_quote $yellow
      set -gx fish_color_redirection $foreground
      set -gx fish_color_end $orange
      set -gx fish_color_error $red
      set -gx fish_color_param $purple
      set -gx fish_color_comment $comment
      set -gx fish_color_selection --background=$selection
      set -gx fish_color_search_match --background=$selection
      set -gx fish_color_operator $green
      set -gx fish_color_escape $pink
      set -gx fish_color_autosuggestion $comment
      set -gx fish_color_cancel $red --reverse
      set -gx fish_color_option $orange

      # Default Prompt Colors
      set -gx fish_color_cwd $green
      set -gx fish_color_host $purple
      set -gx fish_color_host_remote $purple
      set -gx fish_color_user $cyan

      # Completion Pager Colors
      set -gx fish_pager_color_progress $comment
      set -gx fish_pager_color_background
      set -gx fish_pager_color_prefix $cyan
      set -gx fish_pager_color_completion $foreground
      set -gx fish_pager_color_description $comment
      set -gx fish_pager_color_selected_background --background=$selection
      set -gx fish_pager_color_selected_prefix $cyan
      set -gx fish_pager_color_selected_completion $foreground
      set -gx fish_pager_color_selected_description $comment
      set -gx fish_pager_color_secondary_background
      set -gx fish_pager_color_secondary_prefix $cyan
      set -gx fish_pager_color_secondary_completion $foreground
      set -gx fish_pager_color_secondary_description $comment

      set -gx BAT_THEME Dracula
      set -xg MANPAGER "nvim -c 'Man!'"
    '';
    # Prompt customization (simple example)
    functions = {
      fish_greeting = ''
        # Show kernel information
        uname -a
        # Show "ghostty +boo" animation if ghostty is installed
        if command -v ghostty >/dev/null
          ghostty +boo
        end
      '';
      fish_prompt = ''
        if [ $status = 0 ]
          set_color green
          if test -n "$IN_NIX_SHELL"
            echo -n "nix-shell"
          else if git rev-parse 2> /dev/null
            echo -n (git rev-parse --abbrev-ref HEAD 2> /dev/null)
          else
            echo -n (if test (hostname) = localhost; echo nix; else; echo (hostname); end)
          end
        else
          set_color red
          if test -n "$IN_NIX_SHELL"
            echo -n "nix-shell"
          else if git rev-parse 2> /dev/null
            echo -n (git rev-parse --abbrev-ref HEAD)
          else
            echo -n (if test (hostname) = localhost; echo nix; else; echo (hostname); end)
          end
        end
        set_color normal
        echo -n ' ('
        echo -n (prompt_pwd)
        echo -n ') '
      '';
      fish_title = ''
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
      '';
      nix-shell = "command nix-shell --command fish $argv";
    };
    shellAliases = {
      grrrr = "git reset --hard";
      l = "eza -laF --group-directories-first";
      ls = "eza -F --group-directories-first";
      mkdir = "mkdir -p";
      ngit = "git -C ~/git/nixos";
      p = "alejandra -q ~/git/nixos/;git -C ~/git/nixos/ diff;read -lP 'Continue?' && git -C ~/git/nixos/ add .&&git -C ~/git/nixos/ commit -m 'Update Flake'&&git -C ~/git/nixos/ commit --amend&&git -C ~/git/nixos/ push";
      pu = "git -C ~/git/nixos/ pull";
      pw = "openssl rand -base64 30";
      sudo = "sudo -E";
      tree = "eza --tree --git-ignore --group-directories-first";
      watch = "viddy --disable_auto_save";
    };
  };
}

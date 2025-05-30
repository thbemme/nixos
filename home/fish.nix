{pkgs, ...}: {
  home.file = {
    ".config/fish/conf.d/dracula.fish".source = ./dotfiles/fish/dracula.fish;
  };

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
      set -xg MANPAGER "nvim -c 'Man!'"

    '';
    # Prompt customization (simple example)
    functions = {
      fish_greeting = "uname -a";
      fish_prompt = ''
        if [ $status = 0 ]
          set_color green
          if test -n "$IN_NIX_SHELL"
            echo -n "nix-shell"
          else if git rev-parse 2> /dev/null
            echo -n (git rev-parse --abbrev-ref HEAD 2> /dev/null)
          else
            echo -n (hostname)
          end
        else
          set_color red
          if test -n "$IN_NIX_SHELL"
            echo -n "nix-shell"
          else if git rev-parse 2> /dev/null
            echo -n (git rev-parse --abbrev-ref HEAD)
          else
            echo -n (hostname)
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
      p = "alejandra -q ~/git/nixos/;git -C ~/git/nixos/ diff;read -lP 'Continue?' && git -C ~/git/nixos/ add .&&git -C ~/git/nixos/ commit -m 'Update Flake'&&git -C ~/git/nixos/ commit --amend&&git -C ~/git/nixos/ push";
      pu = "git -C ~/git/nixos/ pull";
      ez = "eza --group-directories-first";
      l = "ez -laF";
      ls = "ez -F";
      grrrr = "git reset --hard";
      gs = "git status";
      mkdir = "mkdir -p";
      pw = "openssl rand -base64 30";
      ngit = "git -C ~/git/nixos";
    };
  };
}

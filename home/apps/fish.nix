{
  pkgs,
  vars,
  ...
}: {
  programs.fish = {
    enable = true;
    plugins = with pkgs.fishPlugins; [
      {
        name = "fzf-fish";
        inherit (fzf-fish) src;
      }
      {
        name = "grc";
        inherit (grc) src;
      }
    ];
    # Prompt customization (simple example)
    functions = {
      fish_greeting = ''
        # Show kernel information
        uname -a
        # Show "ghostty +boo" animation if ghostty is installed and conditions are met
        if command -v ghostty >/dev/null 2>&1
          if not set -q IN_NIX_SHELL
            and test (random 1 10) -eq 10
            and test (tput cols) -ge 100
            and test (tput lines) -ge 41
              ghostty +boo
          end
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
      ns = ''
        # Better nix-shell
        if ! nix-shell --packages "$argv" --run "exit" 2>/dev/null
            echo "Package not found. Searching Nixpkgs..."
            nh search "$argv"
        else if ! nix-shell --packages "$argv" --run "$argv"
            echo "Command not found in shell. Opening normal nix-shell..."
            nix-shell --packages "$argv"
        end
      '';
      nix-shell = "command nix-shell --command fish $argv";
    };
    shellAliases = {
      cat = "bat";
      f = "fd -H --no-ignore";
      grrrr = "git reset --hard";
      l = "eza -laF --icons --git --group-directories-first";
      ls = "eza -F --icons --git --group-directories-first";
      mkdir = "mkdir -p";
      ngit = "git -C ~/git/nixos";
      p = "alejandra -q ~/git/nixos/;git -C ~/git/nixos/ diff;read -lP 'Continue?' && git -C ~/git/nixos/ add .&&git -C ~/git/nixos/ commit -m 'Update Flake'&&git -C ~/git/nixos/ commit --amend&&git -C ~/git/nixos/ push";
      pu = "git -C ~/git/nixos/ pull";
      pw = "openssl rand -base64 30";
      sudo = "sudo -E";
      tree = "eza --tree --icons --git --group-directories-first";
      watch = "viddy --unfold --disable_auto_save";
    };
  };
}

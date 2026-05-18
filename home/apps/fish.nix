{pkgs, ...}: {
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
    functions = {
      fish_greeting = ''
        # Show kernel information
        uname -a

        # Show "ghostty +boo" animation if ghostty is installed and conditions are met
        if command -v ghostty >/dev/null 2>&1
          and not set -q IN_NIX_SHELL
          and test (random 1 10) -eq 10
          and test (tput cols) -ge 100
          and test (tput lines) -ge 41
            ghostty +boo
        end
      '';
      fish_prompt = ''
        if test $status -eq 0
          set_color green
        else
          set_color red
        end

        set -l branch (if command -v git >/dev/null 2>&1;git branch --show-current 2>/dev/null; end)
        set -l host_name (if test (uname -n) = localhost; echo nix; else; echo (uname -n); end)
        set -l context (if test -n "$IN_NIX_SHELL"; echo "nix-shell"; else if test -n "$branch"; echo $branch; else; echo $host_name; end)

        echo -n $context
        set_color normal
        echo -n " ($(prompt_pwd)) "
      '';
      fish_title = ''
        # this one sets the X terminal window title
        # argv[1] has the full command line
        echo (uname -n): (prompt_pwd): $argv[1]

        switch "$TERM"
        case 'screen*'

          # prepend hostname to screen(1) title only if on ssh
          if set -q SSH_CLIENT
            set maybehost (uname -n):
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

{
  lib,
  pkgs,
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
    functions = {
      fish_greeting = ''
        # Show kernel information
        uname -a

        # Show "ghostty +boo" animation if ghostty is installed and conditions are met
        if command -v ghostty >/dev/null 2>&1
          and not set -q IN_NIX_SHELL
          and test (random 0 10) -eq 10
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
        set -l nixshell_cmd (command -v nom-shell || echo nix-shell)
        if ! $nixshell_cmd --packages "$argv" --run "exit"
            echo "Package could not be fetched."
            nh search "$argv"
        else if ! $nixshell_cmd --packages "$argv" --run "$argv"
            echo "Command not found in shell. Opening normal nix-shell..."
            nix-shell --packages "$argv"
        end
      '';
      nix-shell = "command nix-shell --command fish $argv";
    };
    shellAliases = {
      cat = "${lib.getExe pkgs.bat}";
      f = "${lib.getExe pkgs.fd} -H --no-ignore";
      grrrr = "${lib.getExe pkgs.git} reset --hard";
      l = "${lib.getExe pkgs.eza} -laF --icons --git --group-directories-first";
      ls = "${lib.getExe pkgs.eza} -F --icons --git --group-directories-first";
      mkdir = "mkdir -p";
      ngit = "${lib.getExe pkgs.git} -C ~/git/nixos";
      p = "${lib.getExe pkgs.alejandra} -q ~/git/nixos/;${lib.getExe pkgs.git} -C ~/git/nixos/ diff;read -lP 'Continue?' && ${lib.getExe pkgs.git} -C ~/git/nixos/ add .&&${lib.getExe pkgs.git} -C ~/git/nixos/ commit -m 'Update Flake'&&git -C ~/git/nixos/ commit --amend&&${lib.getExe pkgs.git} -C ~/git/nixos/ push";
      pu = "${lib.getExe pkgs.git} -C ~/git/nixos/ pull";
      pw = "${lib.getExe pkgs.openssl} rand -base64 30";
      sudo = "sudo -E";
      tree = "${lib.getExe pkgs.eza} --tree --icons --git --group-directories-first";
      watch = "${lib.getExe pkgs.viddy} --unfold --disable_auto_save";
    };
  };
}

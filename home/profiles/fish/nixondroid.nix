_: {
  programs.fish = {
    shellInit = ''
      set -Ux fish_features no-keyboard-protocols
      sshagent
      ssh-add -L > /dev/null || ssh-add
    '';
    shellAliases = {
      r = "nix-on-droid switch -F ~/git/nixos/ $argv";
      c = "nix-collect-garbage -d";
    };
    functions = {
      sshagent = ''
        if test -z (pgrep ssh-agent | string collect)
            eval (ssh-agent -c)
            set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
            set -Ux SSH_AGENT_PID $SSH_AGENT_PID
        end'';
    };
  };
}

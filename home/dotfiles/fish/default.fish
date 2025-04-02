function fish_greeting
  uname -a
end

function fish_prompt
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

function nix-shell
  /run/current-system/sw/bin/nix-shell --command /run/current-system/sw/bin/fish -p $argv
end

function p
  nixpkgs-fmt ~/git/nixos/;git -C ~/git/nixos/ diff;read -lP 'Continue?' && git -C ~/git/nixos/ add .&&git -C ~/git/nixos/ commit -m 'Update Flake'&&git -C ~/git/nixos/ commit --amend&&git -C ~/git/nixos/ push
end

function pu
  git -C ~/git/nixos/ pull
end
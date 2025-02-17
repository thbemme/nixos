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

ssh-add -L > /dev/null || ssh-add

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

function p
  nixpkgs-fmt ~/git/nixos/;git -C ~/git/nixos/ diff;read -lP 'Continue?' && git -C ~/git/nixos/ add .&&git -C ~/git/nixos/ commit -m 'Update Flake'&&git -C ~/git/nixos/ commit --amend&&git -C ~/git/nixos/ push
end

function pu
  git -C ~/git/nixos/ pull
end

function r
  nh os switch $argv -- --impure
end
function u
  nh os switch --update $argv -- --impure
end
function c
  nh clean all --keep 5
end

function enable_proxy
  alpaca-proxy -C http://proxypac.solco.global.nttdata.com/proxy.pac >/dev/null 2>&1 &
  disown (jobs -p)
  set -Ux http_proxy http://localhost:3128
  set -Ux https_proxy http://localhost:3128
  set -Ux ftp_proxy http://localhost:3128
  sudo mkdir -p /run/systemd/system/nix-daemon.service.d/
  sudo bash -c 'cat << EOF >/run/systemd/system/nix-daemon.service.d/proxy-override.conf
  [Service]
  Environment="http_proxy=localhost:3128"
  Environment="https_proxy=localhost:3128"
  Environment="all_proxy=localhost:3128"
EOF'
  sudo systemctl daemon-reload
  sudo systemctl restart nix-daemon
end

function disable_proxy
  set -e http_proxy
  set -e https_proxy
  set -e ftp_proxy
  set -e NTLM_CREDENTIALS
  sudo rm /run/systemd/system/nix-daemon.service.d/proxy-override.conf
  sudo systemctl daemon-reload
  sudo systemctl restart nix-daemon
  pkill alpaca-proxy
end

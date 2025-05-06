ssh-add -L > /dev/null || ssh-add

function r
  nh os switch --ask $argv -- --impure
end
function u
  nh os switch --update --ask $argv -- --impure
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

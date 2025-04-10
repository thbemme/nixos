# My NixOS configuration and setup
- [My NixOS configuration and setup](#my-nixos-configuration-and-setup)
  - [Modules](#modules)
    - [Generative AI/LLM](#generative-aillm)
    - [AMD GPU](#amd-gpu)
    - [Desktop/Desktop-software](#desktopdesktop-software)
    - [Development](#development)
    - [Gaming](#gaming)
    - [Gnome](#gnome)
    - [Printing](#printing)
    - [Prometheus](#prometheus)
    - [Secure Boot](#secure-boot)
    - [Security](#security)
    - [VIM](#vim)
    - [Virtualization](#virtualization)
    - [Work related](#work-related)
  - [Gitcrypt](#gitcrypt)
  - [Desktop](#desktop)
    - [Installation](#installation)
    - [Maintenance](#maintenance)
  - [WSL](#wsl)
    - [Installation](#installation-1)
    - [Maintenance](#maintenance-1)
  - [Nix-on-droid](#nix-on-droid)
    - [Installation](#installation-2)
    - [Maintenance](#maintenance-2)

## Modules
### [Generative AI/LLM](modules/ai.nix)
- Comfyui
- Mimic (TTS)
- Ollama
- Open-webui
- oterm
### [AMD GPU](modules/amdgpu.nix)
- CoreCTRL (Undervolting GPU)
- Vulkan Tools
### [Desktop](modules/desktop.nix)/[Desktop-software](modules/desktop-software.nix)
- Default packages: Librewolf, Ghostty, VSCodium, Libreoffice, GIMP
### [Development](modules/dev.nix)
- Thony (Micropython for Raspberry Pico development)
- Android Studio (Unstable)
### [Gaming](modules/gaming.nix)
- Lutris
- Stream
- Wine
### [Gnome](modules/gnome.nix)
- Gnome desktop environment
- Default theme: Dracula
### [Printing](modules/printing.nix)
- Setup printer and scanner
### [Prometheus](modules/prometheus.nix)
- Prometheus exporter for Grafana monitoring
### [Secure Boot](modules/secureboot.nix)
- Enabling Secure Boot
### [Security](modules/security.nix)
- Nmap
- Wireshark
- Misc security and auditing tools
### [VIM](modules/vim.nix)
- Customized Vim config
### [Virtualization](modules/virt.nix)
- Gnome Boxes
- UEFI fix
- Qemu
### [Work related](modules/work.nix)
- Citrix Client
- Alpaca Proxy
## Gitcrypt
- [Setup steps](https://lgug2z.com/articles/handling-secrets-in-nixos-an-overview/#managing-your-own-physical-machines)

- Make sure `git` and `git-crypt` is installed:
```shell
nix-shell -p git git-crypt
```
- Get key as base64
```shell
git-crypt export-key -|base64 -w0
```

- Save key
- Decrypt with base64 key
```shell
stty -echo;head -n1|base64 -d|git crypt unlock -;stty echo
```

- Sample config file  [variables.json](./variables.json.sample)

## Desktop
### Installation
1. Clone repo
```shell
git clone https://git.kbnetcloud.de/riza/nixos.git ~/git/nixos
cd ~/git/nixos
```
2. Decrypt [git-crypt](#gitcrypt)
3. Setup disk
- **Warning: The disksetup scripts will delete all partitions on `nvme0n1`, `sda` or `vda`**
- One btrfs volume with subvolumes for `rootfs`, `home` and `nix`
- Physical volumes (nvme, sda) encrypted via cryptsetup
- Virtual volumes (vda) unencrypted
- Swap via `zram`
```shell
scripts/disksetup_<type>.sh
```
4. Generate Hardware configuration
```shell
nixos-generate-config --root /mnt --show-hardware-config > hosts/<host>/hardware-configuration.nix
```
- Check if btrfs mountpoints  have `"compress=zstd"` parameter or add it manually
5. Start installation for `<hostname>` and set `<username>` password
```shell
nixos-install --flake .#<hostname> --no-root-password
nixos-enter --root /mnt -c "passwd <username>"
```
### Maintenance
- `nh` is being used to maintain NixOS
- Update with `u [--dry]`
- Reconfiguration with `r [--dry]`
- Push to git with `p`
- Pull from git with `pu`

## WSL
### Installation
1. Follow NixOS installation on WSL from https://github.com/nix-community/NixOS-WSL
2. Clone repo
```shell
git clone https://git.kbnetcloud.de/riza/nixos.git ~/git/nixos
cd ~/git/nixos
```
3. Decrypt [git-crypt](#gitcrypt)

4. Update Nix channels
```shell
sudo nix-channel --update
```
5. Switch to new configuration
```shell
sudo nixos-rebuild switch --flake .#<hostname> --impure
```
6. Restart Nixos
```shell
wsl -t nixos
```
7. Set password for your user
```shell
wsl -d NixOS --user root
passwd <user>
```
### Maintenance
- `nh` is being used to maintain NixOS
- Update with `u [--dry]`
- Reconfiguration with `r [--dry]`
- Push to git with `p`
- Pull from git with `pu`
## Nix-on-droid
### Installation
1. Install app from [F-droid](https://f-droid.org/packages/com.termux.nix/)
2. Enable Flake install and let installation configure base system
3. Add `openssh` and `git` packages under `.config/nix-on-droid/nix-on-droid.nix`
4. Clone repo
```shell
git clone https://git.kbnetcloud.de/riza/nixos.git
```
1. Decrypt [git-crypt](#gitcrypt)

2. Switch to new config
```shell
nix-on-droid -F ~/nixos/
```
### Maintenance
- `nix-on-droid` to maintain nix-on-droid
- Reconfiguration with `r [--dry]`
- Pull from git with `pu`


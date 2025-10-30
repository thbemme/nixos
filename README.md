# 🌈 My NixOS configuration and setup <!-- omit from toc -->

- [Modules](#modules)
  - [AMD GPU](#amd-gpu)
  - [Development](#development)
  - [Gaming](#gaming)
  - [Generative AI/LLM](#generative-aillm)
  - [Ghostty](#ghostty)
  - [Gnome](#gnome)
  - [GUI/GUI-Extras](#guigui-extras)
  - [Hibernation](#hibernation)
  - [Kernels desktop/server](#kernels-desktopserver)
  - [Librewolf](#librewolf)
  - [NeoVim](#neovim)
  - [Printing](#printing)
  - [Prometheus](#prometheus)
  - [Secure Boot](#secure-boot)
  - [Security](#security)
  - [SSH](#ssh)
  - [Virtualization](#virtualization)
  - [Work related](#work-related)
- [Gitcrypt](#gitcrypt)
- [Native NixOS](#native-nixos)
  - [Maintenance](#maintenance)
- [WSL](#wsl)
  - [Maintenance](#maintenance-1)
- [Nix-on-droid](#nix-on-droid)
  - [Maintenance](#maintenance-2)
- [Home-manager](#home-manager)
  - [Maintenance](#maintenance-3)

## Modules

### [AMD GPU](modules/hardware/amdgpu.nix)

- CoreCTRL (Undervolting GPU)
- Vulkan Tools

### [Development](modules/profiles/dev.nix)

- Thonny (Micropython for Raspberry Pico development)
- Android Studio (Unstable)

### [Gaming](modules/profiles/gaming.nix)

- Lutris
- Stream
- Wine

### [Generative AI/LLM](modules/services/llm.nix)

- Comfyui
- Mimic (TTS)
- Ollama
- Open-webui
- oterm

### [Ghostty](home/apps/ghostty.nix)

- Customized Ghostty config

### [Gnome](modules/profiles/gnome.nix)

- Gnome desktop environment
- Default theme: Dracula

### [GUI](modules/profiles/gui-minimal.nix)/[GUI-Extras](modules/profiles/gui-extras.nix)

- Desktop applications

### [Hibernation](modules/system/hibernate.nix)

- Hibernate on power button pressed
- Sleep then hibernate on lid close

### [Kernels](modules/system/kernel-default.nix) [desktop](modules/system/kernel-desktop.nix)/[server](modules/system/kernel-server.nix)

- Kernel settings for desktop and server
 
### [Librewolf](home/apps/librewolf.nix)

- Customized Librewolf config

### [NeoVim](home/apps/neovim.nix)

- Customized nvim config

### [Printing](modules/services/printing.nix)

- Setup printer and scanner

### [Prometheus](modules/services/prometheus.nix)

- Prometheus exporter for Grafana monitoring

### [Secure Boot](modules/system/secureboot.nix)

- Enabling Secure Boot

### [Security](modules/profiles/security.nix)

- Nmap
- Wireshark
- Misc security and auditing tools

### [SSH](modules/services/ssh.nix)

- SSH Remote log in

### [Virtualization](modules/services/virt.nix)

- Gnome Boxes
- UEFI fix
- Qemu

### [Work related](modules/profiles/work.nix)

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

- Sample config file [variables.json](./secrets/variables.json.sample)

## Native NixOS

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
- Server variant assuming classic BIOS setting not UEFI
- Swap via `zram`

```shell
scripts/disksetup_<type>.sh
```

4. Generate Hardware configuration

```shell
nixos-generate-config --root /mnt --show-hardware-config > hosts/<host>/hardware-configuration.nix
```

- Check if btrfs mountpoints have `"compress=zstd"` parameter or add it manually

5. Start installation for `<hostname>` and set `<username>` password

```shell
nixos-install --flake .#<hostname> --no-root-password
```

### Maintenance

- `nh` is being used to maintain NixOS
- Update with `u [--dry]`
- Reconfiguration with `r [--dry]`
- Cleanup with `c`
- Push to git with `p`
- Pull from git with `pu`

## WSL

1. Follow NixOS installation on WSL from https://github.com/nix-community/NixOS-WSL
2. Clone repo

```shell
git clone https://git.kbnetcloud.de/riza/nixos.git ~/git/nixos
cd ~/git/nixos
```

3. Decrypt [git-crypt](#gitcrypt)

4. Update Nix channels

```shell
nix-channel --update
```

5. Switch to new configuration

```shell
nixos-rebuild switch --flake .#<hostname> --impure
```

6. Restart Nixos

```shell
wsl -t nixos
```

### Maintenance

- `nh` is being used to maintain NixOS
- Update with `u [--dry]`
- Reconfiguration with `r [--dry]`
- Cleanup with `c`
- Push to git with `p`
- Pull from git with `pu`

## Nix-on-droid

1. Install app from [F-droid](https://f-droid.org/packages/com.termux.nix/)
2. Enable Flake install and let installation configure base system
3. Add `openssh` and `git` packages under `.config/nix-on-droid/nix-on-droid.nix`
4. Clone repo

```shell
git clone https://git.kbnetcloud.de/riza/nixos.git
```

5. Decrypt [git-crypt](#gitcrypt)

6. Switch to new config

```shell
nix-on-droid -F ~/nixos/
```

### Maintenance

- `nix-on-droid` to maintain nix-on-droid
- Reconfiguration with `r [--dry]`
- Pull from git with `pu`

## Home-manager

Requirements:
Any GNU/Linux with native package installed:

- [Gnome Desktop Environment](https://www.gnome.org/)
- [Ghostty](https://ghostty.org/docs/install/binary)
- SELinux disabled/permissive

1. Install nix packet manager

```shell
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
```

2. Enable flake feature

```shell
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

3. Clone repo

```shell
git clone https://git.kbnetcloud.de/riza/nixos.git ~/git/nixos
cd ~/git/nixos
```

4. Decrypt [git-crypt](#gitcrypt)
5. Switch to home-manager shell

```shell
nix-shell -p home-manager
```

6. Activate initial configuration

```shell
home-manager switch --flake ~/git/nixos/#hm
```

### Maintenance

- `home-manager` to maintain nix environment
- Reconfiguration with `r [--dry-run]`
- Cleanup with `c`
- Pull from git with `pu`

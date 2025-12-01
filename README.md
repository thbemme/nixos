# 🌈 My NixOS configuration and setup

**A modular, reproducible, and secure NixOS configuration for homeservers, workstations, WSL, and Nix-on-Droid.**

---

## 📌 Overview
This repository contains my **NixOS** and **Home Manager** configurations for various environments, including:
- **Native NixOS** (Desktops, Servers)
- **WSL** (Windows Subsystem for Linux)
- **Nix-on-Droid** (Android devices)
- **Home Manager** (Nix on other GNU/Linux distributions)

The setup is **modular**, **reproducible**, and **secure**, with support for **GitCrypt** for secrets management.

---

## 📂 Structure
   | Directory/File | Description                                                   |
   |----------------|---------------------------------------------------------------|
   | `home/`        | Home Manager configurations and user-specific settings        |
   | `hosts/`       | Host-specific configurations (e.g., `mikrobi/`, `puffy/`)     |
   | `modules/`     | Reusable NixOS modules (hardware, profiles, services, system) |
   | `scripts/`     | Utility scripts for setup and maintenance                     |
   | `secrets/`     | Sensitive data and configuration (encrypted with GitCrypt)    |

---

## 🔧 Modules

### Hardware
 | Module                                  | Description                                  |
 |-----------------------------------------|----------------------------------------------|
 | [AMD GPU](modules/hardware/amdgpu.nix)  | CoreCTRL, Vulkan Tools, and GPU undervolting |
 | [LED control](modules/hardware/led.nix) | Control LED colors                           |

### Profiles
 | Module                                        | Description                                  |
 |-----------------------------------------------|----------------------------------------------|
 | [Development](modules/profiles/dev.nix)       | Thonny, Android Studio (unstable)            |
 | [Gaming](modules/profiles/gaming.nix)         | Lutris, Steam, Wine                          |
 | [GNOME](modules/profiles/gnome.nix)           | GNOME desktop environment with Dracula theme |
 | [GUI](modules/profiles/gui-minimal.nix)       | Minimal GUI applications                     |
 | [GUI Extras](modules/profiles/gui-extras.nix) | Additional GUI applications                  |
 | [Security](modules/profiles/security.nix)     | Nmap, Wireshark, and auditing tools          |
 | [Work](modules/profiles/work.nix)             | Citrix Client, Alpaca Proxy                  |

### Services
 | Module                                        | Description                                     |
 |-----------------------------------------------|-------------------------------------------------|
 | [Generative AI/LLM](modules/services/llm.nix) | ComfyUI, Mimic (TTS), Ollama, Open-WebUI, oterm |
 | [Printing](modules/services/printing.nix)     | Printer and scanner setup                       |
 | [Prometheus](modules/services/prometheus.nix) | Prometheus exporter for Grafana monitoring      |
 | [SSH](modules/services/ssh.nix)               | SSH remote login configuration                  |
 | [Virtualization](modules/services/virt.nix)   | GNOME Boxes, UEFI fix, QEMU                     |

### System
 | Module                                       | Description                                                  |
 |----------------------------------------------|--------------------------------------------------------------|
 | [Hibernation](modules/system/hibernate.nix)  | Hibernate on power button, sleep then hibernate on lid close |
 | [Kernels](modules/system/kernel-default.nix) | Default, desktop, and server kernel settings                 |
 | [Plymouth](modules/system/plymouth.nix)      | Plymouth graphical boot process settings                     |
 | [Secure Boot](modules/system/secureboot.nix) | Secure Boot configuration                                    |

### Home Manager
 | Module                               | Description                                |
 |--------------------------------------|--------------------------------------------|
 | [Ghostty](home/apps/ghostty.nix)     | Customized Ghostty terminal configuration  |
 | [Librewolf](home/apps/librewolf.nix) | Customized Librewolf browser configuration |
 | [NeoVim](home/apps/neovim.nix)       | Customized NeoVim configuration            |

---

## 🔐 Gitcrypt
**GitCrypt** is used to encrypt sensitive files (e.g., `secrets/variables.json`).
### Setup
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
### Unlock the repository

```shell
stty -echo;head -n1|base64 -d|git crypt unlock -;stty echo
```

- Sample config file [variables.json](./secrets/variables.json.sample)

## 💻 Native NixOS

1. Clone repo

```shell
git clone https://git.kbnetcloud.de/riza/nixos.git ~/git/nixos
cd ~/git/nixos
```

2. Decrypt [git-crypt](#gitcrypt)
3. Setup disk

- **⚠️ Warning**: The disksetup scripts will delete all partitions on `nvme0n1`, `sda` or `vda`
- One btrfs volume with subvolumes for `rootfs`, `home` and `nix`
- Physical volumes (nvme, sda) encrypted via cryptsetup
- Virtual volumes (vda) unencrypted
- GPT-based configuration for modern UEFI systems using systemd-boot
- MBR-based configuration for legacy BIOS systems using the GRUB bootloader
- Swap via `zram`

```shell
scripts/disksetup_gpt.sh
# Or  
scripts/disksetup_mbr.sh
```

4. Generate Hardware configuration

```shell
nixos-generate-config --root /mnt --show-hardware-config > hosts/<host>/hardware-configuration.nix
```

- Check if btrfs mountpoints have `"compress=zstd"` parameter or add it manually

5. Start installation for `<hostname>`. Password is defined in the secrets json:

```shell
nixos-install --flake .#<hostname> --no-root-password
```

### Maintenance

- `nh` is being used to maintain NixOS
- Update with `u`
- Reconfiguration with `r`
- Cleanup with `c`
- Push to git with `p`
- Pull from git with `pu`

## 🪟 WSL

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

- Use `nh` for maintenance (same commands as Native NixOS).

## 📱 Nix-on-droid

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
- Reconfiguration with `r [--dry-run]`
- Pull from git with `pu`

## 🏠 Home-manager

Requirements:
Any GNU/Linux with native package installed:

- [Gnome Desktop Environment](https://www.gnome.org/)
- [Ghostty](https://ghostty.org/docs/install/binary)
- SELinux disabled/permissive

1. Install [nix packet manager](https://nixos.org/download/)

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

## 📜 License
This project is licensed under the **MIT License**.

# My NixOS configuration and setup
## Modules
### [AI](modules/ai.nix)
- Comfyui
- Mimic (TTS)
- Ollama
- Open-webui
### [AMD GPU](modules/amdgpu.nix)
- CoreCTRL (Undervolting GPU)
- Vulkan Tools
### [Development](modules/dev.nix)
- Thony (Micropython for Raspberry Pico development)
- Android Studio (Unstable)
### [Gaming](modules/gaming.nix)
- Lutris
- Stream
- Wine
### [Prometheus](modules/prometheus.nix)
- Prometheus exporter for Grafana monitoring
### [VIM](modules/vim.nix)
- Customized Vim config
### [Virtualization](modules/virt.nix)
- Gnome Boxes
- UEFI fix
- Qemu
### [Work related](modules/work.nix)
- MS Teams
- Citrix Client
- Alpaca Proxy
## Desktop
### Installation
1. Clone repo
```
git clone https://git.kbnetcloud.de/user/nixos.git ~/git/nixos
```
2. Setup disk
- **Warning: The disksetup scripts will delete all partitions on `nvme0n1`, `sda` or `vda`**
- One btrfs volume with subvolumes for `rootfs`, `home` and `nix`
- Physical volumes (nvme, sda) encrypted via cryptsetup
- Virtual volumes (vda) unencrypted
- Swap via `zram`
```
scripts/disksetup_<type>.sh
```
3. Generate Hardware configuration
```
nixos-generate-config --root /mnt --show-hardware-config > hosts/<host>/hardware-configuration.nix
```
- Check if btrfs mountpoints  have `"compress=zstd"` parameter or add it manually
4. Start installation for `<hostname>` and set `<username>` password
```
nixos-install --flake /home/nixos/nixos#<hostname> --no-root-password
nixos-enter --root /mnt -c "passwd <username>"
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
```
git clone https://git.kbnetcloud.de/user/nixos.git
```
5. Switch to new config
```
nix-on-droid -F ~/nixos/
```
### Maintenance
- `nix-on-droid` to maintain nix-on-droid
- Reconfiguration with `r [--dry]`
- Pull from git with `pu`
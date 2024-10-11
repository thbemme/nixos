# My NixOS configuration and setup
## Desktop
### Installation
1. Clone repo
```
git clone https://git.kbnetcloud.de/user/nixos.git ~/git/nixos
```
2. Setup disk
- **Warning: The disksetup scripts will delete all partitions on `nvme0n1`, `sda` or `vda`**
- One btrfs volume with subvolumes for `home` and `nix`
- nvme and sda type create a encrypted volume 
- vda type creates a unencrypted volume
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
- Several aliases exist to keep OS updated using `nh`
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
- Several aliases exist to keep OS updated using `nix-on-droid`
- Reconfiguration with `r [--dry]`
- Pull from git with `pu`
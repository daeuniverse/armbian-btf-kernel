# armbian-btf-kernel

## Upgrade to BTF Kernel on Armbian Linux

1. Backup your system using `clonezilla` or other tools, if you can't access the grub menu to choose the kernel when booting.

2. Check your board famlily:

   ```shell
   uname -r
   ```

3. Download corresponding kernel debs from [Releases](https://github.com/daeuniverse/armbian-btf-kernel/releases/latest).

4. Extract debs and install:
   ```shell
   tar -xvf <downloaded_kernel_pkg.tar>
   dpkg -i linux-*.deb
   ```

5. Reboot your machine.

## Failed to boot after installation?

Method 1: Choose the original kernel in grub menu when booting.

Method 2: Restore your system if you have a backup.

## Cannot find your kernel?

> **Note**
> Make sure you have clicked `Show all assets` on the releases page.

If you don't find the kernel you need in the list, [open an issue](https://github.com/daeuniverse/armbian-btf-kernel/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc) to submit your request.

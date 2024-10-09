# Kali NetHunter Pro - Mobile Penetration Testing Platform

[Kali NetHunter Pro](](https://www.kali.org/get-kali/#kali-mobile)) is a Mobile Penetration Testing Platform.

[![Kali NetHunter Pro Logo](./pictures/kali-nethunterpro-logo-dragon-orange-transparent.png)](./pictures/kali-nethunterpro-logo-dragon-orange-transparent.png)

# NetHunter Pro recipes

A set of [debos](https://github.com/go-debos/debos) recipes for building a Kali Linux based image for mobile phones, initially targetting Pine64's PinePhone.

Prebuilt images are available [here](https://www.kali.org/get-kali/#kali-mobile).

The [default user](https://www.kali.org/docs/introduction/default-credentials/) is `kali` with password `1234`.

## Build

To build the image, you need to have `debos` and `bmaptool`. On a Kali Linux system, install these dependencies by typing the following command in a terminal:

```console
sudo apt install debos bmap-tools f2fs-tools
```

If you want to build with EXT4 filesystem f2fs-tools is not required.

Note: DNS resolution may break after installing the above packages. To fix this, add a valid DNS resolver (e.g., `1.1.1.1`) to the file `/etc/systemd/resolved.conf` and then `sudo systemctl restart systemd-resolved.service`

The build system will cache and re-use it's output files.
To create a fresh build remove `*.tar.gz`, `*.sqfs` and `*.img` before starting the build.

Then simply browse to the `kali-nethunter-pro` folder and execute `./build.sh`.

You can use `./build.sh -d` to use the docker version of `debos`.

### Building QEMU image

You can build a QEMU x86_64 image by adding the `-t amd64` flag to `build.sh`

The resulting files are raw images. You can start qemu like so:

```
qemu-system-x86_64 -drive format=raw,file=<imagefile.img> -enable-kvm -cpu host -vga virtio -m 2048 -smp cores=4 -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE.fd
```
UEFI firmware files are available in Debian thanks to the [OVMF](https://packages.debian.org/sid/all/ovmf/filelist) package. Comprehensive explanation about firmware files can be found at [OVMF project's repository](https://github.com/tianocore/edk2/tree/master/OvmfPkg).

You may also want to convert the raw image to qcow2 format and resize it like this:

```console
qemu-img convert -f raw -O qcow2 <raw_image.img> <qcow_image.qcow2>
qemu-img resize -f qcow2 <qcow_image.qcow2> +20G
```

## Install

Insert a MicroSD card into your computer, and type the following command:

```
sudo dd if=<image> of=/dev/<sdcard> bs=1M
```

*Note: Make sure to use your actual SD card device, such as `mmcblk0` instead of
`<sdcard>`.*

**CAUTION: This will format the SD card and erase all its contents!!!**

### Install via Windows 

You can use balena etcher to install the image downloaded onto the sd card. Start etcher and select the image file, target (which would be the sd card) and then "Flash". 

# License

This software is licensed under the terms of the [GNU General Public License, version 3](https://www.kali.org/docs/policy/kali-linux-open-source-policy/).

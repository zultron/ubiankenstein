# `ubiankenstein`:  Install Debian kernels in Ubuntu

This repo builds an Ubuntu `.deb` package for Ubuntu 20.04 Focal that
enables installing Debian 11 Bullseye kernel packages (or any
packages, really) through `apt-get install`.

It configures APT to install Debian packages, but at lowest priority
so Ubuntu packages will be preferred:

- Adds Debian package repo configurations to `/etc/apt/sources.list`
- [Pins][1] all Debian packages priority -10

It also enables installing Debian `linux-headers` packages (for
building kernel modules) by shimming package dependencies to install
Ubuntu packages that satisfy Debian package requirements:

- `gcc`:  `Depends: gcc-10`, `Provides: linux-compiler-gcc-10-x86`
- Firmware:  `Depends: linux-firmware`, `Provides: firmware-linux-free`

## How to use

Build the package, if needed.

    sudo apt-get install dpkg-dev debhelper
    dpkg-buildpackage -uc -b
    cd ..

Install the package, refresh APT repos, and install the RT_PREEMPT
kernel.

    # Install the package
    sudo apt-get install ./ubiankenstein_*_amd64.deb
    # Update APT package cache
    sudo apt-get update
    # Install Linux RT_PREEMPT kernel and headers
    sudo apt-get install linux-image-rt-amd64 linux-headers-rt-amd64

## Updating

To update Debian repo package keys, edit `./debian/update_keys.sh` and
add or replace package key fingerprints, run the script, and commit
the changes to git.

[1]: https://help.ubuntu.com/community/PinningHowto

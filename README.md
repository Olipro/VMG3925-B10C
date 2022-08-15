# Zyxel VMG3925-B10C

This repository contains the provided GPL sources from Zyxel.

Notably, this code appears to be substantially newer than the last firmware version I could find - in any case, it certainly builds and runs successfully on my device, despite appearing to be configured for a VMG3926.

## Building

The official instructions state that you should use Ubuntu 12.04 32-bit - Given the fact that the VMG1312 buildroot generated a garbage image if you didn't use the instructed distribution, I have not bothered trying it on any other system.

As usual, since it's a legacy ubuntu release, you'll need to modify `/etc/apt/sources.list` to replace all instances of `whatever.ubuntu.com` with `old-releases.ubuntu.com`

After this, you can `apt-get install g++ flex bison gawk make autoconf zlib1g-dev libncurses-dev git subversion gettext libtool` and simply run `make` in the root of this tree.

## Verification

Assuming you have the sources from Zyxel, reset this repo to the initial commit (with `git reset` or however you prefer) and then extract the contents of the tarball they sent you directly on top. `git status` should indicate no changes. If it does, `git diff` it and examine.

## Binaries

I have provided two different binaries on the releases page. One of them contains a patched version of `su` in busybox which will allow you to escalate your privilege to root which is usable over telnet from the supervisor account.

In order to get the supervisor password, see https://openwrt.org/toh/zyxel/nr7101 - the bash script only returns the "old" password, so remove the pipe to sed from the script and you'll get a full list.

It is **strongly recommended** that, after logging in as supervisor and using `su` to escalate to root that you use `passwd` to change the credentials to whatever you want and then reflash the "normal" version that doesn't have an `su` with no password checking.

If you want to reproduce this hack yourself, after running `make` once, you can go down into `build_dir/` and patch `su.c` in the busybox sources. If you don't know enough C for this to be enough information for you, don't attempt it.


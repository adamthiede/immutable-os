#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# rpmfusion install/uninstall
rpm-ostree install \
  "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${RELEASE}.noarch.rpm"

rpm-ostree update \
	--uninstall rpmfusion-free-release \
	--install rpmfusion-free-release

rpm-ostree override remove sddm-wayland-sway sddm \
	firefox firefox-langpacks sway-config-fedora \
	virtualbox-guest-additions \
	--install sway-config-upstream
rpm-ostree override remove nano nano-default-editor \
	--install vim-default-editor

# install preferred packages
rpm-ostree install mpv ffmpeg sway foot bemenu j4-dmenu-desktop \
	fzf git curl htop neovim vim tmux go rbw wmenu \
	xfce-polkit terminus-fonts wl-clipboard w3m aerc \
	android-tools aria2 btop cargo rust curl dino discount \
	doas fastfetch flashrom i3blocks i3status i3 imv isync \
	jq kanshi keepassxc minetest mosh mousepad mpc mpd ncmpcpp \
	ncdu nethack newsboat nmap pmbootstrap rsync seahorse \
	NetworkManager-tui syncthing tailscale \
	xorg-x11-server-Xorg xorg-x11-drv-intel xorg-x11-drv-libinput

#### Example for enabling a System Unit File
#systemctl enable podman.socket

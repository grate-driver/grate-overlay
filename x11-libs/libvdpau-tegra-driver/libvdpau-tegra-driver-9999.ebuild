# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools git-r3 udev

DESCRIPTION="HW accelerated video decoding and output support for Tegra20 SoC's"
HOMEPAGE="https://github.com/grate-driver/libvdpau-tegra"
EGIT_REPO_URI="https://github.com/grate-driver/libvdpau-tegra.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm"

VIDEO_CARDS="tegra grate"
for card in ${VIDEO_CARDS}; do
	IUSE_VIDEO_CARDS+=" video_cards_${card}"
done

IUSE="${IUSE_VIDEO_CARDS}"

RDEPEND=">=x11-libs/libdrm-2.4.81[video_cards_tegra?,video_cards_grate?]
	x11-libs/libvdpau
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libXv
	x11-drivers/xf86-video-opentegra
	virtual/libudev
"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	eautoreconf
}

pkg_postinst() {
	udev_reload && udevadm trigger --name-match=tegra_vde
}

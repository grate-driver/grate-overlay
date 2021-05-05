# grate-overlay
Gentoo overlay for the grate-driver projects. Add the grate-overlay to layman and enjoy!

    layman -f -o https://raw.githubusercontent.com/grate-driver/grate-overlay/master/overlay.xml -a grate-overlay

The tegra mesa component now depends on nouveau for vdpau. Add `-vdpau` and `-video_cards_nouveau` to `/etc/portage/profile/use.mask`, otherwise portage will ignore them as they are masked by the default ARM profile.

A ebuild has been made "sys-config/grate" to make the install of grate-overlay packages , profiles and masks easy to apply :

    emerge --ask sys-config/grate

GL support is lacking, so anything wayland will use the software render.

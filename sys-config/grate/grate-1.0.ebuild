# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="A configuration for portage to make the install from grate easy"
HOMEPAGE="https://github.com/grate-driver"

KEYWORDS="~arm"

SRC_URI=""

LICENSE="GPL-2+"
SLOT="0"
IUSE=""

DEPEND="
	sys-apps/portage
"
RDEPEND="${DEPEND}"

#checking dirs
pkg_setup() {
	if [ -f "${PORTAGE_CONFIGROOT%/}/etc/portage/profile" ]; then
		eerror "${PORTAGE_CONFIGROOT%/}/etc/portage/profile is a file not a directory.  Please convert profile to a directory with the current contents of profile being moved to a file inside it."
		die
	fi

	if [ -f "${PORTAGE_CONFIGROOT%/}/etc/portage/package.mask" ]; then
		eerror "${PORTAGE_CONFIGROOT%/}/etc/portage/package.mask is a file not a directory.  Please convert package.mask to a directory with the current contents of package.mask being moved to a file inside it."
		die
	fi
}
pkg_preinst() {
	GENTOOGRATE_PORTDIR=$(portageq get_repo_path ${PORTAGE_CONFIGROOT} grate-overlay)
	GRATE_PORTAGE_DIR="${GENTOOGRATE_PORTDIR}/${CATEGORY}/${PN}/files"

	COMMON_OVERRIDES=(
		use.mask
	)

	#Install main workarounds files
	for i in "${COMMON_OVERRIDES[@]}"; do
		elog "Installing ${i} override"
		dosym "${GRATE_PORTAGE_DIR}/profile/${i}" "${PORTAGE_CONFIGROOT%/}/etc/portage/profile/${i}"
	done

	COMMON_MASKS=(
		grate
	)

	#Install main mask file for media-libs/mesa::gentoo
	for l in "${COMMON_MASKS[@]}"; do
		elog "Installing ${l} masks"
		dosym "${GRATE_PORTAGE_DIR}/package.mask/${l}" "${PORTAGE_CONFIGROOT%/}/etc/portage/package.mask/${l}"
	done
}

pkg_postinst()
{
	elog "Grate have added "${PORTAGE_CONFIGROOT%/}/etc/portage/profile/${i}" override to the system"
	elog "Grate have added "${PORTAGE_CONFIGROOT%/}/etc/portage/package.mask/${l}" masks to the system"
}

################################################################################
#
# libsodium
#
################################################################################

LIBSODIUM_VERSION = 1.0.3
LIBSODIUM_SITE = https://download.libsodium.org/libsodium/releases/
LIBSODIUM_INSTALL_STAGING = YES
LIBSODIUM_DEPENDENCIES = host-pkgconf
#LIBSODIUM_LICENSE = GPLv2

$(eval $(autotools-package))


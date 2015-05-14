################################################################################
#
# libuecc
#
################################################################################

LIBUECC_VERSION = 5
LIBUECC_SITE = http://git.universe-factory.net/libuecc/snapshot/
LIBUECC_INSTALL_STAGING = YES
LIBUECC_DEPENDENCIES = host-pkgconf
#LIBUECC_LICENSE = GPLv2

$(eval $(cmake-package))


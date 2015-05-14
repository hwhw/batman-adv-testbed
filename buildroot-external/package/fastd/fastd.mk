################################################################################
#
# fastd
#
################################################################################

FASTD_VERSION = 17
FASTD_SITE = http://git.universe-factory.net/fastd/snapshot/
#FASTD_LICENSE = GPLv2
FASTD_DEPENDENCIES = libsodium libcap libuecc json-c host-bison host-pkgconf
FASTD_CONF_OPTS = -DENABLE_SYSTEMD=OFF -DENABLE_LTO=OFF -DCMAKE_AR=$(TARGET_AR) -DCMAKE_RANLIB=$(TARGET_RANLIB) -DCMAKE_NM=$(TARGET_NM)
ifeq ($(BR2_PACKAGE_FASTD_WITH_OPENSSL),y)
FASTD_CONF_OPTS += -DENABLE_OPENSSL=ON
FASTD_DEPENDENCIES += openssl
endif

$(eval $(cmake-package))


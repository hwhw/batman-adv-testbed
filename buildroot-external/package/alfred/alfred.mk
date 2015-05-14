################################################################################
#
# alfred
#
################################################################################

ALFRED_VERSION = 2015.0
ALFRED_SITE = http://downloads.open-mesh.org/batman/releases/batman-adv-$(ALFRED_VERSION)
ALFRED_LICENSE = GPLv2
ALFRED_DEPENDENCIES = libcap # host-pkgconf

define ALFRED_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) CONFIG_ALFRED_GPSD=n all
endef

define ALFRED_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) CONFIG_ALFRED_GPSD=n \
		PREFIX=/usr DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))


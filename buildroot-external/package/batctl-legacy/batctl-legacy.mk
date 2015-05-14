################################################################################
#
# batctl-legacy
#
################################################################################

BATCTL_LEGACY_VERSION = 2013.4.0
BATCTL_LEGACY_SOURCE = batctl-$(BATCTL_LEGACY_VERSION).tar.gz
BATCTL_LEGACY_SITE = http://downloads.open-mesh.org/batman/releases/batman-adv-$(BATCTL_LEGACY_VERSION)
BATCTL_LEGACY_LICENSE = GPLv2
BATCTL_LEGACY_DEPENDENCIES = libnl host-pkgconf

define BATCTL_LEGACY_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) all
endef

define BATCTL_LEGACY_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		PREFIX=/usr DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))

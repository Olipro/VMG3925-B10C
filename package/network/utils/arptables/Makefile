# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=arptables
ifeq ("$(strip ${ZCFG_PLATFORM})","QUALCOMM")
PKG_VERSION:=0.0.4
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@ZyXEL_SITE/private/Qualcomm/network/drivers/wifi_SPF8.0-ipq807x
PKG_LICENSE:=GPL-2.0
else
PKG_VERSION:=0.0.3-4
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@SF/ebtables
PKG_MD5SUM:=1d4ab05761f063b0751645d8f2b8f8e5

endif

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-v$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/arptables
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Firewall
  TITLE:=ARP firewalling software
  DEPENDS:=+kmod-arptables
  URL:=http://ebtables.sourceforge.net
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		$(TARGET_CONFIGURE_OPTS) \
		COPT_FLAGS="$(TARGET_CFLAGS)" \
		KERNEL_DIR="./include/linux"
endef

define Package/arptables/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(CP) $(PKG_BUILD_DIR)/$(PKG_NAME) $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,arptables))

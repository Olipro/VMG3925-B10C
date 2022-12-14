include $(TOPDIR)/rules.mk

PKG_NAME:=ubus
ifeq ("$(strip ${ZCFG_PLATFORM})","QUALCOMM")
PKG_VERSION:=2015-05-25
PKG_SOURCE_VERSION:=f361bfa5fcb2daadf3b160583ce665024f8d108e
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
else ifeq ("$(strip ${ZCFG_PLATFORM})","ECONET")
PKG_VERSION:=2015-05-25
PKG_SOURCE_VERSION:=f361bfa5fcb2daadf3b160583ce665024f8d108e
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PATCH_DIR:=patches-econet
else 
PKG_VERSION:=2012-12-15
#PKG_RELEASE=$(PKG_SOURCE_VERSION)

#PKG_SOURCE_PROTO:=git
#PKG_SOURCE_URL:=git://nbd.name/luci2/ubus.git
#PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
#PKG_SOURCE_VERSION:=bb856ad8a9a1e786494d01e34bbfe2b4d2134021
#PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_MIRROR_MD5SUM:=fe419893677d12e6455bbe5e3b503944

PKG_RELEASE:=bb856ad8a9a1e786494d01e34bbfe2b4d2134021
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.gz
endif
CMAKE_INSTALL:=1
PKG_SOURCE_URL:=@ZyXEL_SITE/opensource/misc

PKG_LICENSE:=LGPLv2.1
PKG_LICENSE_FILES:=

PKG_MAINTAINER:=Felix Fietkau <nbd@openwrt.org>

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/ubus
  SECTION:=luci2
  CATEGORY:=LuCI2
  SUBMENU:=System
  DEPENDS:=+libubus +libblobmsg-json +ubusd
  TITLE:=OpenWrt RPC client utility
endef

define Package/ubusd
  SECTION:=luci2
  CATEGORY:=LuCI2
  SUBMENU:=System
  TITLE:=OpenWrt RPC daemon
  DEPENDS:=+libubox +libubus
endef

define Package/libubus
  SECTION:=luci2
  CATEGORY:=LuCI2
  SUBMENU:=Libraries
  DEPENDS:=+libubox
  TITLE:=OpenWrt RPC client library
endef

define Package/libubus-lua
  SECTION:=luci2
  CATEGORY:=LuCI2
  SUBMENU:=Libraries
  DEPENDS:=+libubus +liblua
  TITLE:=Lua binding for the OpenWrt RPC client
endef

TARGET_CFLAGS += -I$(STAGING_DIR)/usr/include

CMAKE_OPTIONS = \
	-DLUAPATH=/usr/lib/lua

define Package/ubus/install
	$(INSTALL_DIR) $(1)/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/ubus $(1)/bin/
endef

define Package/ubusd/install
	$(INSTALL_DIR) $(1)/sbin
	$(CP) $(PKG_INSTALL_DIR)/usr/sbin/ubusd $(1)/sbin/
ifeq ("$(strip ${ZCFG_PLATFORM})","ECONET")
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/msg $(1)/usr/bin
endif

endef

define Package/libubus/install
	$(INSTALL_DIR) $(1)/lib
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/* $(1)/lib/
endef

define Package/libubus-lua/install
	$(INSTALL_DIR) $(1)/usr/lib/lua
	$(CP) $(PKG_BUILD_DIR)/lua/ubus.so $(1)/usr/lib/lua/
endef

$(eval $(call BuildPackage,ubus))
$(eval $(call BuildPackage,ubusd))
$(eval $(call BuildPackage,libubus))
$(eval $(call BuildPackage,libubus-lua))


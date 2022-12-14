#
# Copyright (C) 2010-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=minidlna
PKG_VERSION:=1.2.1
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)_$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=@ZyXEL_SITE/opensource/network/services

PKG_BUILD_PARALLEL:=0
PKG_BUILD_DEPENDS:=util-linux

PATCH_DIR=patches_${PKG_VERSION}

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/minidlna
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=UPnP A/V & DLNA Media Server
  URL:=http://minidlna.sourceforge.net/
  DEPENDS:= +libpthread +libexif +libjpeg +libsqlite3 +libffmpeg \
  	+libid3tag +libflac +libvorbis +libuuid \
  	$(ICONV_DEPENDS) $(INTL_DEPENDS)
endef

define Package/minidlna/description
  MiniDLNA (aka ReadyDLNA) is server software with the aim of
  being fully compliant with DLNA/UPnP-AV clients.
endef

define Package/minidlna/conffiles
/etc/minidlna.conf
endef

TARGET_CPPFLAGS += \
	-I$(STAGING_DIR)/usr/include \
	-I$(STAGING_DIR)/usr/include/FLAC \
	-I$(STAGING_DIR)/usr/include/libavcodec \
	-I$(STAGING_DIR)/usr/include/libavformat \
	-I$(STAGING_DIR)/usr/include/libavutil \
	-I$(STAGING_DIR)/usr/include/libexif \
	-I$(STAGING_DIR)/usr/include/uuid \
	-I$(STAGING_DIR)/usr/include/vorbis \
	-I$(ICONV_PREFIX)/include \
	-I$(INTL_PREFIX)/include \
	-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 \

TARGET_LDFLAGS += \
	-L$(ICONV_PREFIX)/lib \
	-L$(INTL_PREFIX)/lib \
	-Wl,-rpath-link=$(STAGING_DIR)/usr/lib \

MAKE_FLAGS +=\
	CFLAGS="$(TARGET_CFLAGS) $(TARGET_CPPFLAGS)" \
	LDFLAGS="$(TARGET_LDFLAGS)" \
	ICONV_LIBS="-liconv $(if $(INTL_FULL),-lintl)" \

MAKE_VARS +=\
	PREFIX="$(STAGING_DIR)/usr" \
	ICONV_PREFIX="$(ICONV_PREFIX)" \
	INTL_PREFIX="$(INTL_PREFIX)" \
	OS_NAME="OpenWrt Linux" \
	OS_VERSION="$(LINUX_VERSION)" \
	OS_URL="http://openwrt.org/" \
	DB_PATH="/var/run/minidlna" \
	LOG_PATH="/var/log" \


define Package/minidlna/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/minidlnad $(1)/usr/bin/
#	$(INSTALL_DIR) $(1)/etc/init.d
#	$(INSTALL_BIN) ./files/minidlna.init $(1)/etc/init.d/minidlna
#	$(INSTALL_DIR) $(1)/etc/config
#	$(INSTALL_CONF) ./files/minidlna.config $(1)/etc/config/minidlna
endef

define Package/minidlna/conffiles
/etc/config/minidlna
endef

$(eval $(call BuildPackage,minidlna))

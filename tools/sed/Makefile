# 
# Copyright (C) 2006-2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=sed
PKG_VERSION:=4.2.1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
#PKG_SOURCE_URL:=@GNU/$(PKG_NAME)
PKG_MD5SUM:=7d310fbd76e01a01115075c1fd3f455a
PKG_CAT:=bzcat
export SED:=
PKG_SOURCE_URL:=@ZyXEL_SITE/opensource/tools/editor

HOST_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/host-build.mk

HOST_CONFIGURE_ARGS += \
	--disable-acl \
	--disable-nls \

HOST_CONFIGURE_VARS += \
	ac_cv_search_setfilecon=no \
	ac_cv_header_selinux_context_h=no \
	ac_cv_header_selinux_selinux_h=no \

define Host/Compile
	+$(MAKE) $(HOST_JOBS) -C $(HOST_BUILD_DIR) SHELL="$(BASH)" LDFLAGS="$(HOST_STATIC_LINKING)"
endef

define Host/Install
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/sed/sed $(STAGING_DIR_HOST)/bin/
endef

define Host/Clean
	rm -f $(STAGING_DIR_HOST)/bin/sed
endef

$(eval $(call HostBuild))

#
# Copyright (C) 2009-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=mpc
#PKG_VERSION:=0.9
PKG_VERSION:=1.0.3

#PKG_SOURCE_URL:=http://www.multiprecision.org/mpc/download/
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
#PKG_MD5SUM:=0d6acab8d214bd7d1fbbc593e83dd00d
PKG_MD5SUM:=d6a1d5f8ddea3abd2cc3e98f58352d26
PKG_SOURCE_URL:=@ZyXEL_SITE/opensource/tools

HOST_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/host-build.mk

unexport CFLAGS

HOST_CONFIGURE_ARGS += \
	--enable-static \
	--disable-shared \
	--with-mpfr=$(TOPDIR)/staging_dir/host \
	--with-gmp=$(TOPDIR)/staging_dir/host

$(eval $(call HostBuild))

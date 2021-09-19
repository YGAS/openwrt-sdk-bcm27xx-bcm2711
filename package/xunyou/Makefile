#
# Copyright (C) 2015-2016 OpenWrt.org
# Copyright (C) 2020 jjm2473@gmail.com
#
# This is free software, licensed under the GNU General Public License v3.
#

include $(TOPDIR)/rules.mk

PKG_ARCH_LINKEASE:=$(ARCH)

PKG_NAME:=xunyou
PKG_VERSION:=0.1.1
PKG_RELEASE:=1
PKG_SOURCE:=$(PKG_NAME)-binary-$(PKG_VERSION).tar.gz


PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-binary-$(PKG_VERSION)

PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Web Servers/Proxies
	TITLE:=xunyou
	DEPENDS:=
endef

define Package/$(PKG_NAME)/description
	xunyou
endef


define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)
	cp -pR ./files/xunyou $(1)/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
include $(THEOS)/makefiles/common.mk

#TARGET = iphone:clang:12.2:10.00

#SYSROOT = $(THEOS)/sdks/iPhoneOS12.2.sdk

BUNDLE_NAME = CellularX
CellularX_FILES = CellularX.m 
CellularX_INSTALL_PATH = /Library/PreferenceBundles
CellularX_FRAMEWORKS = UIKit
CellularX_CFLAGS = -fobjc-arc
CellularX_PRIVATE_FRAMEWORKS = Preferences

ARCHS = arm64 arm64e

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/CellularX.plist$(ECHO_END)
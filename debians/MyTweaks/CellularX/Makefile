#TARGET = iphone:clang:12.2:10.00

#SYSROOT = $(THEOS)/sdks/iPhoneOS12.2.sdk

TWEAK_NAME = CellularX
CellularX_OBJCC_FILES = Tweak.x
CellularX_CFLAGS = -F $(SYSROOT)/System/Library/CoreServices -fobjc-arc
CellularX_FRAMEWORKS = Foundation UIKit
CellularX_PRIVATE_FRAMEWORKS = Foundation
FINALPACKAGE = 1

ARCHS = arm64 arm64e

SUBPROJECTS += CellularXSettings

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/bundle.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

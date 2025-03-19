THEOS_PACKAGE_SCHEME = rootless
FINALPACKAGE=1
TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = LINE
THEOS_DEVICE_IP = 192.168.1.126
THEOS_DEVICE_PORT = 22


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = LIME-for-iOS

LIME-for-iOS_FILES = Tweak.xm
LIME-for-iOS_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

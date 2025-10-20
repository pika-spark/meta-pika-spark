DESCRIPTION = "Minimal Pika Spark image, based on arduino-console-image."

LICENSE = "MIT"

inherit core-image

IMAGE_FEATURES += " \
    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', '', \
       bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11-base', '', d), d)} \
"

IMAGE_FEATURES:remove = "${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'x11-base', '', d)}"

include recipes-support/images/arduino-image.inc

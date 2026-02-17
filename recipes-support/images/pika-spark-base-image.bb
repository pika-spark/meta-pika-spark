DESCRIPTION = "Minimal Pika Spark image, based on arduino-console-image."

LICENSE = "MIT"

inherit core-image

IMAGE_FEATURES += " \
    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', '', \
       bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11-base', '', d), d)} \
"

IMAGE_FEATURES:remove = "${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'x11-base', '', d)}"

IMAGE_INSTALL:append = " minicom vim"

include recipes-support/images/arduino-image.inc

# Override default arduino user with pika user and set password to "spark"
# Generated with: echo -n "spark" | openssl passwd -6 -stdin
ARDUINO-USER = "pika"
EXTRA_USERS_PARAMS += "usermod -p '\$6\$HJKkvY1/KSMtssMC\$nWmdFd5aio.Uc8/aKTkItewgWtqUUHgWtYBqXRTT8jGVvzftzi7.bdRvABlLC6p3xZI6QX.LdPdiZsOTC3yFp.' ${ARDUINO-USER};"

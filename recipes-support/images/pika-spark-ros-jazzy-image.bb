DESCRIPTION = "Pika Spark image with ROS 2 Jazzy, extending the base image."

LICENSE = "MIT"

require ${THISDIR}/pika-spark-base-image.bb

inherit ros_distro_jazzy
inherit ros2_image

# ros_image.bbclass would append "-jazzy" to IMAGE_BASENAME by default.
# Suppress this since the distro is already encoded in the recipe name.
ROS_IMAGE_BASENAME_APPEND = ""

IMAGE_INSTALL:append = " ros-core"
IMAGE_INSTALL:append = " packagegroup-pika-ros-examples"

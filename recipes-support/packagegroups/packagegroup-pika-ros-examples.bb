DESCRIPTION = "ROS 2 Jazzy example packages for Pika Spark"
LICENSE = "MIT"

inherit packagegroup
inherit ros_distro_jazzy

RDEPENDS:${PN} = " \
    examples-rclcpp-minimal-publisher \
    examples-rclcpp-minimal-subscriber \
"

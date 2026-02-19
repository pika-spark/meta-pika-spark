FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:portenta-x8 = " \
    file://portenta-x8/overlays/ov_carrier_pika_spark_base.dts \
"

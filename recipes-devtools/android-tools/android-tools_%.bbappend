# Fix hardcoded /home/arduino WorkingDirectory in adbd service
do_install:append () {
    sed -i 's#WorkingDirectory=/home/arduino#WorkingDirectory=/home/pika#g' \
        ${D}${systemd_unitdir}/system/android-tools-adbd.service
}

# Fix hardcoded /home/arduino WorkingDirectory in adbd service and add HOME env var.
# adbd inherits a minimal systemd environment and never consults /etc/passwd when
# spawning shells, so HOME must be injected explicitly at the service level.
do_install:append () {
    sed -i 's#WorkingDirectory=/home/arduino#WorkingDirectory=/home/pika#g' \
        ${D}${systemd_unitdir}/system/android-tools-adbd.service
    sed -i '/^WorkingDirectory=/a Environment=HOME=/home/pika' \
        ${D}${systemd_unitdir}/system/android-tools-adbd.service
}

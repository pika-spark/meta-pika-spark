#!/bin/sh
#
# resize-rootfs.sh - Expand root partition and filesystem to fill available space.
# Intended to run once on first boot via systemd.

set -e

STAMP="/var/lib/resize-rootfs-done"

if [ -f "$STAMP" ]; then
    echo "resize-rootfs: already completed, skipping."
    exit 0
fi

# Determine the root device, e.g. /dev/mmcblk2p2
ROOT_DEV=$(findmnt -n -o SOURCE /)
if [ -z "$ROOT_DEV" ]; then
    echo "resize-rootfs: ERROR - cannot determine root device." >&2
    exit 1
fi

# Derive the disk device and partition number.
# For mmcblk devices the partition suffix is "pN", e.g. /dev/mmcblk2p2 -> /dev/mmcblk2, part 2
case "$ROOT_DEV" in
    /dev/mmcblk*p[0-9]*)
        DISK_DEV=$(echo "$ROOT_DEV" | sed 's/p[0-9]*$//')
        PART_NUM=$(echo "$ROOT_DEV" | sed 's/.*p//')
        ;;
    /dev/sd*[0-9]*)
        DISK_DEV=$(echo "$ROOT_DEV" | sed 's/[0-9]*$//')
        PART_NUM=$(echo "$ROOT_DEV" | sed 's/.*[a-z]//')
        ;;
    *)
        echo "resize-rootfs: ERROR - unsupported device naming: $ROOT_DEV" >&2
        exit 1
        ;;
esac

echo "resize-rootfs: root=$ROOT_DEV disk=$DISK_DEV partition=$PART_NUM"

# Grow the partition to use all remaining space
parted -s "$DISK_DEV" resizepart "$PART_NUM" 100%

# Resize the ext4 filesystem online
resize2fs "$ROOT_DEV"

# Mark as done
mkdir -p "$(dirname "$STAMP")"
touch "$STAMP"

echo "resize-rootfs: completed successfully."

#!/bin/sh

echo "Build id:" $1

if [ "$1" = "" ]; then
    echo "Missing build id."
    exit
fi

if [ "$TMPDIR" = "" ]; then
    TMPDIR="tmp"
    echo "TMPDIR environment variable not specified, assuming" $TMPDIR
fi

if [ "$MACHINE" = "" ]; then
    MACHINE="raspberrypi0-wifi"
    echo "MACHINE environment variable not specified, assuming" $MACHINE
fi

output_folder="build/$MACHINE/$1"

mkdir -p $output_folder

echo "Copying build artifacts to" $output_folder

docker cp berrydev:/home/yoctouser/berry/build/$TMPDIR/deploy/images/$MACHINE/core-image-base-$MACHINE-$1.rootfs.wic.bmap $output_folder
docker cp berrydev:/home/yoctouser/berry/build/$TMPDIR/deploy/images/$MACHINE/core-image-base-$MACHINE-$1.rootfs.wic.bz2 $output_folder

machine_=$(echo $MACHINE | sed -e "s/-/_/g")
docker cp berrydev:/home/yoctouser/berry/build/buildhistory/images/$machine_/musl/core-image-base/build-id.txt $output_folder
docker cp berrydev:/home/yoctouser/berry/build/buildhistory/images/$machine_/musl/core-image-base/installed-package-names.txt $output_folder
docker exec -it berrydev /bin/bash -c "cd /home/yoctouser/berry && source layers/poky/oe-init-build-env > /dev/null && buildhistory-collect-srcrevs -a" > $output_folder/srcrevs.txt

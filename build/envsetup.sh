#!/bin/sh -
# from link http://adcomp.tuxfamily.org/scripts/script_mini_linux.txt
# link http://revcode.wordpress.com/2012/02/25/booting-a-minimal-busybox-based-linux-distro/
wget -O - http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.2.7.tar.bz2 | tar zxv &&
cd linux-3.2.7 &&
make defconfig &&
make &&
wget http://busybox.net/downloads/binaries/latest/busybox-i686 &&
mkdir rootfs
cd rootfs
mkdir dev proc sys tmp
mknod dev/console c 5 1
cat >> init << EOF #!/bin/ash mount -t proc none /proc mount -t sysfs none /sys /bin/ash EOF chmod +x init
find . | cpio -H newc -o | gzip > ../rootfs.cpio.gz
cd ..

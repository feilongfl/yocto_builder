qemu-system-x86_64 --enable-kvm \
 -device virtio-net-pci,netdev=net0,mac=52:54:00:12:35:02 \
 -netdev user,id=net0,hostfwd=tcp::2222-:22,hostfwd=tcp::2323-:23,tftp=/home/feilong/Program-ext/yocto/poky/build/tmp/deploy/images/qemux86-64 \
 -object rng-random,filename=/dev/urandom,id=rng0 -device virtio-rng-pci,rng=rng0 \
 -drive file=/home/feilong/Program-ext/yocto/poky/build/tmp/deploy/images/qemux86-64/core-image-weston-qemux86-64.ext4,if=virtio,format=raw \
 -usb -device usb-tablet   \
 -cpu IvyBridge -machine q35 -smp 4 -m 512 -serial mon:vc -serial null  \
 -kernel /home/feilong/Program-ext/yocto/poky/build/tmp/deploy/images/qemux86-64/bzImage-qemux86-64.bin \
 -append 'root=/dev/vda rw  mem=512M ip=dhcp oprofile.timer=1 tsc=reliable no_timer_check rcupdate.rcu_expedited=1'
 
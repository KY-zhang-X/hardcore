#!/bin/bash
pid=$(lsof -i:1234 | grep :1234 | awk 'NR==1{print}'| awk '{print $2}')
#杀掉对lsof -i:1234 | grep :1234 | awk 'NR==1{print}'| awk '{print $2}'应的进程，如果pid不存在，则不执行
if [ -n "$pid" ]; then
    echo "pid get is "$pid
    kill -9 $pid
    echo "qemu be terminate successfully！"
else
    echo "qemu not start at first"
fi

# qemu-system-i386 -S -s -parallel stdio -hda bin/ucore.img,format=raw \
#                                        -drive file=bin/swap.img,format=raw,media=disk,cache=writeback \
#                                        -drive file=bin/sfs.img,format=raw,media=disk,cache=writeback  \
#                                        -serial null &

# -S              freeze CPU at startup (use 'c' to start execution)
# -s              shorthand for -gdb tcp::1234
# -parallel dev   redirect the parallel port to char device 'dev'
# -hda/-hdb file  use 'file' as IDE hard disk 0/1 image           qemu默认从硬盘启动所以定位到ucore.img

if [ "$1" == "d" ] ; then
	qemu-system-i386 -S -s -drive file=bin/ucore.img,format=raw,index=0,media=disk -drive file=bin/swap.img,format=raw,media=disk,cache=writeback -drive file=bin/sfs.img,format=raw,media=disk,cache=writeback -nographic
else
	qemu-system-i386 -drive file=bin/ucore.img,format=raw,index=0,media=disk -drive file=bin/swap.img,format=raw,media=disk,cache=writeback -drive file=bin/sfs.img,format=raw,media=disk,cache=writeback -nographic
fi


# qemu-system-i386 -S -s -drive file=bin/ucore.img,format=raw,index=0,media=disk -drive file=bin/swap.img,format=raw,media=disk,cache=writeback -drive file=bin/sfs.img,format=raw,media=disk,cache=writeback -nographic

# qemu -drive file=bin/ucore.img,format=raw,index=0,media=disk -drive file=bin/swap.img,format=raw,media=disk,cache=writeback -drive file=bin/sfs.img,format=raw,media=disk,cache=writeback -nographic

# gdb -q -x tools/gdbinit

# sleep 2
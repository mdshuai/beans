```
parted /dev/sda
```

//扩展root分区，`/dev/sda1` 为空闲磁盘
```
pvcreate /dev/sda1
pvdisplay
vgdisplay
vgextend fedora_dhcp-140-57 /dev/sda3
vgdisplay
lvdisplay
lvextend -L +500G /dev/fedora_dhcp-140-57/root
resize2fs /dev/fedora_dhcp-140-57/root   (ext4)
xfs_growfs /dev/fedora_dhcp-140-57/root  (xff)
```

//ec2 扩张root分区， `/dev/xvdq1` 为空闲磁盘
```
fdisk /dev/xvdq1
pvcreate /dev/xvdq1
vgextend rhel /dev/xvdq1
lvextend -l +100%FREE /dev/rhel/root
xfs_growfs /dev/mapper/rhel-root
```

Get the device by using fdisk -l

Then do: fdisk /dev/sdb
Then d - delete a partition
choose the number
Do this iteratively to continue deleteing more partitions.

To create a new partition:
type n to create new partition
p - to make it primary
1 - to make it first partition
ENter - to accept the default first cylinder
Enter - to accept default last cylinder
w - writes the new partition to the device

umount /dev/sdx 

Then you can formate the drive.


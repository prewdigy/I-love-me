#!/bin/bash

# Free memory output to a free_mem.txt file
free -mh > ~/backups/freemem/free_mem.txt

# Disk usage output to a disk_usage.txt file
du -h > ~/backups/diskuse/disk_usage.txt

#List open files to an open_list.txt file
lsof > ~/backups/openlist/open_list.txt

# Free disk space to a free_disk.txt file
df -ih > ~/backups/freedisk/free_disk.txt

#!/bin/sh
# Start vsftpd
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
# Add admin user and password
adduser -D admin
echo "admin:admin" | chpasswd
# Make the FTP directory
mkdir -p /home/admin/ftp
chown -R admin:admin /home/admin/ftp

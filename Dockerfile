# Use an Alpine Linux base image
FROM alpine:latest

# Install vsftpd and other necessary packages
RUN apk add --no-cache vsftpd openssl

# Create the necessary directory for vsftpd
RUN mkdir -p /var/run/vsftpd/empty && chown nobody:nogroup /var/run/vsftpd/empty

# Create a new user 'admin' with password 'admin'
RUN adduser -D admin -h /home/admin && \
    echo "admin:admin" | chpasswd

# Create a directory for FTP files
RUN mkdir -p /home/admin/ftp && \
    chown admin:admin /home/admin/ftp && \
    chmod 555 /home/admin && \
    chmod 755 /home/admin/ftp

# Configure vsftpd
COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose FTP ports
EXPOSE 21 21000-21010 2121

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]





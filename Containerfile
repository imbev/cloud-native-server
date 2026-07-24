FROM quay.io/almalinuxorg/almalinux-bootc:10

RUN dnf update -y && \
    dnf install -y firewalld && \
    dnf clean all

COPY proxy.container /usr/share/containers/systemd/
COPY app.container /usr/share/containers/systemd/

RUN mkdir -p /usr/local/share/proxy
COPY Caddyfile /usr/local/share/proxy

RUN ln -s /usr/share/containers/systemd/* /usr/lib/bootc/bound-images.d/

RUN firewall-offline-cmd --add-port 80/tcp && \
    firewall-offline-cmd --add-port 443/tcp 


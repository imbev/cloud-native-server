FROM quay.io/almalinuxorg/almalinux-bootc:10

RUN dnf update -y && \
    dnf install -y firewalld && \
    dnf clean all

COPY proxy.container /usr/share/containers/systemd/users/
COPY app.container /usr/share/containers/systemd/users/

RUN ln -s /usr/share/containers/systemd/users/* /usr/lib/bootc/bound-images.d/

RUN firewall-offline-cmd --permanent --add-port 443/tcp && \
    firewall-offline-cmd --permanent --add-forward-port=port=443:proto=tcp:toport=8443


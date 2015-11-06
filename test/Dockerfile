FROM centos:centos7
RUN yum clean all
RUN yum install -y sudo openssh-server openssh-clients which curl dbus
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''
RUN if ! getent passwd kitchen; then useradd -d /home/kitchen -m -s /bin/bash kitchen; fi
RUN echo kitchen:kitchen | chpasswd
RUN echo 'kitchen ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN mkdir -p /etc/sudoers.d
RUN echo 'kitchen ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/kitchen
RUN chmod 0440 /etc/sudoers.d/kitchen
RUN [ ! -d /home/kitchen/.ssh ] && mkdir /home/kitchen/.ssh
RUN chown -R kitchen /home/kitchen/.ssh
RUN chmod 0700 /home/kitchen/.ssh
RUN echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBmnJgKErU2HkOLVy0pWiy+/gE1a+AbKljmUYbI26DFwcoITS3GWNx7WlQ5lf7GHVGRObjtT2pR0VFIMjOjOicoFxF55vP9rBSomHbrfYyvG1a3mBIPVmcyy1VbDq7mYqmeOJASKWJqkiFD3iQU6L/t0BTkyV2uzMntUf3GzU3XNIC0/bKgg/ZBqsN9Usp7mYAuoadVsT+ZmczbZO4HLOh3hPI+5Rz/F1/nMDzfPMO2cpP9qMupIgmBkTrl2T61+uziBEhaOXkmqDpfKXwcWntQWjxZzacdgGi8M6sEunOV8epmgexD29XY1T3I0x1CuEyIdCWP3balD5iUR9SEk9R kitchen_docker_key' >> /home/kitchen/.ssh/authorized_keys
RUN chown kitchen /home/kitchen/.ssh/authorized_keys
RUN chmod 0600 /home/kitchen/.ssh/authorized_keys
ENTRYPOINT ["/usr/sbin/init"]
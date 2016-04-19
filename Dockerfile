FROM ubuntu:16.04
MAINTAINER Jason Strothmann <strothjs@gmail.com>
ENV ANSIBLE_VER ansible-2.0.2.0-0.4.rc4
ADD http://releases.ansible.com/ansible/${ANSIBLE_VER}.tar.gz /
RUN tar -C /usr/local -xzf ${ANSIBLE_VER}.tar.gz && \
    mv /usr/local/ansible* /usr/local/ansible && \
    rm /${ANSIBLE_VER}.tar.gz && \
    chmod 0755 /usr/local/ansible/bin/*
RUN apt-get update && apt-get install -y \
    python \
    python-pip \
    python-setuptools && \
    rm -rf /var/lib/apt/lists/*
RUN pip install paramiko PyYAML Jinja2 httplib2 six
ENV ANSIBLE_HOME=/usr/local/ansible \
    PYTHONPATH=/usr/local/ansible/lib:$PYTHONPATH \
    PATH=/usr/local/ansible/bin:$PATH \
    MANPATH=/usr/local/ansible/man:$MANPATH
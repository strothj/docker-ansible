FROM python:2-alpine
MAINTAINER Jason Strothmann <jason@jasons.io>

ENV ANSIBLE_VER ansible-2.2.0.0
ENV ANSIBLE_HOME=/usr/local/ansible \
    PYTHONPATH=/usr/local/ansible/lib:$PYTHONPATH \
    PATH=/usr/local/ansible/bin:$PATH \
    MANPATH=/usr/local/ansible/man:$MANPATH
CMD /bin/bash

RUN apk add --no-cache \
        alpine-sdk \
        bash \
        libffi-dev \
        openssl-dev && \
    wget http://releases.ansible.com/ansible/${ANSIBLE_VER}.tar.gz && \
    tar -C /usr/local -xzf ${ANSIBLE_VER}.tar.gz && \
    mv /usr/local/ansible* /usr/local/ansible && \
    rm /${ANSIBLE_VER}.tar.gz && \
    chmod 0755 /usr/local/ansible/bin/* && \
    pip install paramiko pycrypto PyYAML Jinja2 httplib2 six && \
    apk del \
        alpine-sdk \
        libffi-dev \
        openssl-dev && \
    rm -rf /var/cache/apk/*

# Install text editors so files protected by Ansible Vault can be edited.
# Vim => /usr/bin/vim
# Nano => /usr/bin/nano
RUN apk add --no-cache nano vim
ENV EDITOR=/usr/bin/vim

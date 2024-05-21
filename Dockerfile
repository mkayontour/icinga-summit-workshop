FROM ghcr.io/vmware-tanzu-labs/educates-base-environment:2.6

USER root

RUN HOME=/root && dnf install ansible --repo=fedora --repo=updates -y

USER 1001

RUN ansible-galaxy collection install icinga.icinga

RUN ansible-galaxy collection install community.mysql

RUN ansible-galaxy role install geerlingguy.mysql

COPY --chown=1001:0 . /home/eduk8s/

RUN mv /home/eduk8s/workshop /opt/workshop

RUN fix-permissions /home/eduk8s

#!/bin/sh

# Create homedir

mkdir -p /home/eduk8s/playbooks

cat <<EOF> /home/eduk8s/clouds.yaml
clouds:
  training:
    auth:
      auth_url: "https://cloud.netways.de:5000/v3/"
      project_domain_name: "Default"
      user_domain_name: "Default"
    auth_type: v3password
EOF

### Prepare Role Icinga2

To create a Icinga Server we need to setup the following features. Firstly the CA needs to be set up, features like notifications, API and IcingaDB need to be prepared.

Create another vars file for the icinga server.
```
vim ~/workshop/vars_icinga.yml

icinga2_features:
  - name: api
    ca_host: none
    endpoints:
      - name: "{{ ansible_fqdn }}"
    zones:
      - name: "main"
        endpoints:
          - "{{ ansible_fqdn }}"
  - name: checker
    state: present
  - name: icingadb
    state: present
    host: 127.0.0.1
    port: 6380
  - name: mainlog
    severity: information

icinga2_objects:
  icinga-server.localdomain:   # This needs to be your local FQDN. Check via "hostname -f"
    - name: root
      type: ApiUser
      password: root
      file: local.d/apiuser.conf
      permissions:
        - "*"

icinga2_confd: local.d
icinga2_config_directories:
  - local.d/
```
After editing the variables, include them and the role in the play.

```
vim ~/workshop/play_icinga.yml

- name: Provision Icinga Server
  hosts: icinga-server
  become: true
  vars:
    icinga_repo_subscription_username: icinga-summit-2024
    icinga_repo_subscription_password: Summit2024
  vars_files:
    - vars_database.yml
    - vars_icinga.yml   # Add this line
  roles:
    - icinga.icinga.repos
    - geerlingguy.mysql
    - icinga.icinga.icinga2 # Add this line
```

If this step is done - proceed to the next [step Prepare IcingaDB](06-prepare-icingadb.md)

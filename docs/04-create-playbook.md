### Create Playbook

To provision our server we will create a playbook in the next steps. To keep the variables a bit sorted we will add the variables to specific files and list them in the key **vars_files**.

Create a empty playbook and start by adding the header and the first role.
```
vim ~/workshop/play_icinga.yml
---
- name: Provision Icinga Server
  hosts: icinga-server
  become: true
  vars:
    icinga_repo_subscription_username: icinga-summit-2024
    icinga_repo_subscription_password: Summit2024
  roles:
    - icinga.icinga.repos
```

### Prepare Databases Information

Afterwards we need to prepare our databases. For this we will add the **geerlingguy.mysql** role at the **roles** key.

```
- name: Provision Icinga Server
  hosts: icinga-server
  become: true
  vars:
    icinga_repo_subscription_username: icinga-summit-2024
    icinga_repo_subscription_password: Summit2024
  vars_files:
    - vars_database.yml
  roles:
    - icinga.icinga.repos
    - geerlingguy.mysql
```
Create a seperate vars file for mysql and database related vars, named **database_vars.yml**.
```
vim ~/workshop/vars_database.yml

icingadb_database_name: icingadb
icingadb_database_user: icingadb
icingadb_database_host: 127.0.0.1
icingadb_database_password: icingadb
icingadb_database_type: mysql
icingadb_database_import_schema: true

icingaweb2_db:
  type: mysql
  name: icingaweb
  host: 127.0.0.1
  user: icingaweb
  password: icingaweb

mysql_packages:
  - mariadb-client
  - mariadb-server
  - python3-mysqldb

mysql_users:
  - name: "{{ icingadb_database_user }}"
    host: "%"
    password: "{{ icingadb_database_password }}"
    priv: "{{ icingadb_database_name }}.*:ALL,GRANT"
  - name: "{{ icingaweb2_db.user }}"
    host: "%"
    password: "{{ icingaweb2_db.password }}"
    priv: "{{ icingaweb2_db.name }}.*:ALL"
mysql_databases:
  - name: "{{ icingaweb2_db.name }}"
  - name: "{{ icingadb_database_name }}"
    collation: utf8mb4_general_ci
    encoding: utf8mb4
```

If this step is done - proceed to the next [step Prepare Role Icinga2](05-prepare-role-icinga2.md)

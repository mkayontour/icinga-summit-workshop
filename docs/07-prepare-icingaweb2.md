### Prepare Icingaweb2

In the next step we will add the icingaweb2 to our play. As we are setup the director module later, we need to make sure the Icinga2 core is reloaded after creating the API User.

This means, use the module **flush_handlers** or define a second play in the playbook.

Add this block of code below our first play in the playbook.
```
vim ~/workshop/play_icinga.yml

[...]
- name: Second Part of play to setup icingaweb
  hosts: icinga-server
  vars_files:
    - vars_database.yml
    - vars_icingaweb.yml
  roles:
    - icinga.icinga.icingaweb2
```

Afterwards create the file **vars_icingaweb.yml** with the following content:
```
vim ~/workshop/vars_icingaweb.yml

icingaweb2_admin_username: admin
icingaweb2_admin_password: admin
icingaweb2_db_import_schema: true

icingaweb2_resources:
  icingadb:
    type: db
    db: "{{ icingadb_database_type }}"
    host: localhost
    dbname: "{{ icingadb_database_name }}"
    username: "{{ icingadb_database_user }}"
    password: "{{ icingadb_database_password }}"
    charset: utf8

icingaweb2_modules:
  icingadb:
    enabled: true
    source: package
    commandtransports:
      instance01:
        transport: api
        host: 127.0.0.1
        username: root
        password: root
    config:
      icingadb:
        resource: icingadb
      redis:
        tls: '0'
    redis:
      redis1:
        host: localhost
```

If this step is done - proceed to the next [step Run Plabook](08-run-playbook.md)

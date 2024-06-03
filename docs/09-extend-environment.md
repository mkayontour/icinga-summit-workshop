### Extend Environment with Director and Plugins

#### Add Director database variables

First add new director variables at the **vars_database.yml** file.

```
[...]
icingadb_database_import_schema: true

# Add this block of vars
director_db_host: 127.0.0.1
director_db_name: director
director_db_username: director
director_db_password: director

[...]

mysql_users:
  - name: "{{ director_db_username }}" # Add this mysql user
    host: "%"
    password: "{{ director_db_password }}"
    priv: "{{ director_db_name }}.*:ALL"
    [...]

mysql_databases:
  - name: "{{ director_db_name }}"  # Add this mysql database
    encoding: utf8                  #
  - name: "{{ icingaweb2_db.name }}"
  - name: "{{ icingadb_database_name }}"
    collation: utf8mb4_general_ci
    encoding: utf8mb4
```

#### Add Director module configuration

Afterwards add the module to **icingaweb2_modules** variable.

```
icingaweb2_modules:
  director:
    enabled: true
    source: package
    import_schema: true
    run_kickstart: true
    kickstart:
      config:
        endpoint: "{{ ansible_fqdn }}"
        host: 127.0.0.1
        username: root
        password: root
    config:
      db:
        resource: director_db


```

#### Add Director resources

In addition add the resource of our director database to icingaweb2 too.

```
icingaweb2_resources:
  icingadb:
    type: db
    db: "{{ icingadb_database_type }}"
    host: "{{ icingadb_database_host }}"
    dbname: "{{ icingadb_database_name }}"
    username: "{{ icingadb_database_user }}"
    password: "{{ icingadb_database_password }}"
    charset: utf8
  director_db:
    type: db
    db: mysql
    host: "{{ director_db_host }}"
    dbname: "{{ director_db_name }}"
    username: "{{ director_db_username }}"
    password: "{{ director_db_password }}"
    charset: utf8
```

### Add monitoring_plugins

To finish the complete monitoring, we need to install the monitoring_plugins as well.

Add the following variable to the Icinga vars file and add the role monitoring_plugins in the play.

```
vim ~/workshop/vars_icinga.yml

icinga_monitoring_plugins_check_commands:
    - "all"

[...]
```

Add role **monitoring_plugins**.

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
    - vars_icinga.yml
  roles:
    - icinga.icinga.repos
    - geerlingguy.mysql
    - icinga.icinga.icinga2
    - icinga.icinga.icingadb
    - icinga.icinga.icingadb_redis
    - icinga.icinga.monitoring_plugins

```

To run the playbook again use the following command:

`ansible-playbook -i ~/workshop/inventory play_icinga.yml`

Afterwards check out your local IP address and access the webinterface.

The Director Module should be visible and accessible to you. Happy monitoring :)




### The End

Thanks for taking part at the workshop. Hopefully you got a good overview over the Icinga collection and its features.

If you need further assistance with Ansible or Icinga, feel free to reach out to [NETWAYS GmbH](https://netways.de) anytime. 

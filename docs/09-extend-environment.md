### Extend Environment

#### Add database variables

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

#### Add module configuration

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

#### Add resources

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

Thanks for taking part at the workshop. Hopefully you took away a good overview over the Icinga collection and its features.

If you need further assistance with Ansible or Icinga, feel free to reach out to [NETWAYS GmbH](https://netways.de). 

### Prepare IcingaDB

As we defined the database variables previously we only need to add the two related roles.
**icingadb, icingadb_redis**

```
vim ~/workshop/play_icinga.yml

- name: Provision Icinga Server
  hosts: icinga-server
  become: true
  vars_files:
    - vars_database.yml
    - vars_icinga.yml
  roles:
    - icinga.icinga.repos
    - geerlingguy.mysql
    - icinga.icinga.icinga2
    - icinga.icinga.icingadb       # Add these lines
    - icinga.icinga.icingadb_redis #
```

If this step is done - proceed to the next [step Prepare IcingaDB](docs/07-prepare-icingaweb2.md)

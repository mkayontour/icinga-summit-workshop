### Prepare Collections and Roles

Install the "icinga.icinga" collection with the ansible-galaxy command. If you have ansible-core installed,
please make sure you have version 2.12.9 or greater, otherwise the galaxy command cannot install collections.

```
ansible-galaxy collection install icinga.icinga
```

To later provision a database backend for our instance too, install the role geerlingguy.mysql

```
ansible-galaxy install geerlingguy.mysql
```

If you using **ansible-core**, please make sure the collection **community.mysql is installed**.

```
~# ansible-doc -l | grep community.mysql
community.mysql.mysql_db                                                       Add or remove MySQL databases from a remote ...
community.mysql.mysql_info                                                     Gather information about MySQL ser...
community.mysql.mysql_query                                                    Run MySQL que...
community.mysql.mysql_replication                                              Manage MySQL replica...
community.mysql.mysql_user                                                     Adds or removes a user from a MySQL data...
community.mysql.mysql_variables                                                Manage MySQL global varia...
```

If this command doesn't show a similar output please install the collection:

```
ansible-galaxy collection install community.mysql
```

If this step is done - proceed to the next [step Build local inventory](docs/03-build-local-inventory.md)

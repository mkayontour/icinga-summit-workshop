### Build local inventory
To simplify the process we will just use the collection locally. Otherwise we would need a separate ansible controller to play around on.

Start by creating a ansible directory in your user home and then creating a inventory file.

```
install -d ~/workshop
```
The inventory has a single line.
```
echo "icinga-server ansible_connection=local" > ~/workshop/inventory
```
Test if everything is working, use the following command to check parameters/connection.
```
ansible -m ping -i ~/workshop/inventory icinga-server
```

If this step is done - proceed to the next [step Create Playbook](04-create-playbook.md)

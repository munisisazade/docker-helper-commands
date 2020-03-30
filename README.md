# Usefull comands while working with docker containers



- These comands avalible for  Linux and MacOS operating systems.



### Installation ###

- In order to install comands you require to have sudo privileged. if below comand does not work try with sudo.

```
$ curl -LO https://raw.githubusercontent.com/munisisazade/docker-helper-commands/master/install.sh && bash install.sh
```

### List of Usefull Comands ### 
```bash
build-docker
down-docker
connect-docker
dangling-remove-docker
restart-docker
migrate-docker
logs-docker
backup-database-docker
restore-database-docker
```

### Usage ###

```bash
build-docker
Building multi-containers. Comand should given where your compose file exist. 

down-docker
Stoping runnig multi-containers in the directory.

connect-docker
Executing inside running docker container, with bash. 
ex: connect-docker bash container_id 

dangling-remove-docker
This comand removes Inactive containers and stalled images.

restart-docker
This comand restarting multi-containers in the given directory.

migrate-docker
The comand useful for django projects in case you have migration file and needs to migrated to DB.
ex: migrate-docker container_name_or_id



logs-docker
This comand tailing logs of multi-containers in the given directory.

backup-database-docker
Taking backup file of running Postgres container.


restore-database-docker
Restoring runnig postgres container.

```

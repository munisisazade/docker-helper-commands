#!/bin/bash
# Author Munis Isazade Django developer

VERSION="0.1"
ERROR_STATUS=0
LOCAL_COMMAND_DIRECTORY=~/.local/bin/
ROOT_COMMAND_DIRECTORY=/bin/
WORKING_DIRECTRY=$(pwd)
ISSUE_URL="https://github.com/munisisazade/docker-helper-commands/issues"


#usage: ChangeColor $COLOR text/background
function ChangeColor()
{
	TYPE=""
	case "$2" in
	"text") TYPE="setaf"
	;;
	"back") TYPE="setab"
	;;
	*) TYPE="setaf"
	esac



	case "$1" in
	"red") tput "$TYPE" 1
	;;
	"orange") tput "$TYPE" 3
	;;
	"blue") tput "$TYPE" 4
	;;
	"green") tput "$TYPE" 2
	;;
	"black") tput "$TYPE" 0
	;;
	"white") tput "$TYPE" 7
	;;
	"magenta") tput "$TYPE" 5
	;;
	"cyan") tput "$TYPE" 7
	;;
	*) tput "$TYPE" 0
	esac
}

function usage {
	echo -e "Thans for using this tool:"
	if [ "$EUID" -ne 0 ]; then
		echo -e "You install $(whoami) user all shels here $LOCAL_COMMAND_DIRECTORY"
	else
		echo -e "You install $(whoami) user all shels here $ROOT_COMMAND_DIRECTORY"
	fi
	echo -e "Usage:"
    	echo -e "$(ChangeColor blue text)  build-docker $(ChangeColor green text)Update and create docker compose up $(ChangeColor white text)"
    	echo -e "\n"
    	echo -e "$(ChangeColor blue text)  down-docker $(ChangeColor green text) Down all docker compose containers $(ChangeColor white text)"
    	echo -e "\n"
    	echo -e "$(ChangeColor blue text)  connect-docker <sh|bash> <container_name> $(ChangeColor green text) Connect available docker container with sh or bash $(ChangeColor white text)"
    	echo -e "\n"
    	echo -e "$(ChangeColor blue text)  dangling-remove-docker $(ChangeColor green text) Remove dangling images and containers $(ChangeColor white text)"
    	echo -e "\n"
	echo -e "Run $(ChangeColor blue text)create-django-app --help$(ChangeColor white text) to see all options."
	echo -e "\n"
  	echo -e "  If you have any problems, do not hesitate to file an issue:"
  	echo -e "    $(ChangeColor blue text)$ISSUE_URL$(ChangeColor white text)"
}


function build_docker_shell() {
	touch build-docker
	echo "#!/bin/bash" >> build-docker
	echo "" >> build-docker
	echo "echo -e \"Command Created by Munis\"" >> build-docker
	echo "echo -e \"Building docker-compose containers ...\"" >> build-docker
	echo "docker-compose up --build -d" >> build-docker
	echo "echo -e \"Successfuly build  ....  [OK]\"" >> build-docker
}

function down_docker_shell() {
	touch down-docker
	echo "#!/bin/bash" >> down-docker
	echo "" >> build-docker
	echo "echo -e \"Command Created by Munis\"" >> down-docker
	echo "echo -e \"Down all containers .. width docker-composefile\"" >> down-docker
	echo "" >> down-docker
	echo "docker-compose down" >> down-docker
}

function connect_docker_shell() {
	touch connect-docker
	echo "#!/bin/bash" >> connect-docker
	echo "" >> connect-docker
	echo "echo -e \"Command Created by Munis\"" >> connect-docker
	echo "echo -e \"Connecting with \$1  inside \$2 container with docker command \"" >> connect-docker
	echo "docker exec -it \$2 \$1" >> connect-docker
}

function dangling_remove_docker_shell() {
	touch dangling-remove-docker
	echo "#!/bin/bash" >> dangling-remove-docker
	echo "" >> dangling-remove-docker
	echo "echo -e \"Remove all exited images\"" >> dangling-remove-docker
	echo "docker rmi \$(docker images -f dangling=true -q)" >> dangling-remove-docker
	echo "" >> dangling-remove-docker
	echo "echo -e \"Remove all exited containers\"" >> dangling-remove-docker
	echo "docker rm \$(docker ps -a -f status=exited -q)" >> dangling-remove-docker
}

function restart_docker_shell() {
	touch restart-docker
	echo "#!/bin/bash" >> restart-docker
	echo "" >> restart-docker
	echo "echo -e \"Command Created by Munis\"" >> restart-docker
	echo "echo -e \"Restart all containers\"" >> restart-docker
	echo "docker-compose restart" >> restart-docker
	echo "" >> restart-docker
}

function migrate_docker_shell() {
	touch migrate-docker
	echo "#!/bin/bash" >> migrate-docker
	echo "" >> migrate-docker
	echo "echo -e \"Command Created by Munis\"" >> migrate-docker
	echo "echo -e \"Migrate django project inside \$1 container ...\"" >> migrate-docker
	echo "" >> migrate-docker
	echo "docker exec -it \$1 sh -c \"/venv/bin/python manage.py makemigrations --no-input && /venv/bin/python manage.py migrate --no-input\"" >> migrate-docker
	echo "" >> migrate-docker
}

function logs_docker_shell() {
	touch logs-docker
	echo "#!/bin/bash" >> logs-docker
	echo "" >> logs-docker
	echo "echo -e \"Command Created by Munis\"" >> logs-docker
	echo "echo -e \"Tails all logs on docker containers\"" >> logs-docker
	echo "" >> logs-docker
	echo "\"docker-compose logs -f\"" >> logs-docker
	echo "" >> logs-docker
}


function backup_database_shell() {
	touch backup-database-docker
	echo "#!/bin/bash" >> backup-database-docker
	echo "" >> backup-database-docker
	echo "echo -e \"Command Created by Munis\"" >> backup-database-docker
	echo "echo -e \"Backup Posgresql Database\"" >> backup-database-docker
	echo "" >> backup-database-docker
	echo "if [ \"\$1\" ]; then" >> backup-database-docker
	echo "   docker exec -t \$1 pg_dumpall -c -U postgres > dump_\`date +%d-%m-%Y\"_\"%H_%M_%S\`.sql" >> backup-database-docker
	echo "   echo -e \"Successfuly created Dump file name: \$(tput setaf 2 && tput bold)dump_\`date +%d-%m-%Y\"_\"%H_%M_%S\`.sql  \"" >> backup-database-docker
	echo "else" >> backup-database-docker
	echo "   echo -e \"Please Select Database Container name for example \"" >> backup-database-docker
	echo "   echo -e \"backup-database-docker postgres-db \"" >> backup-database-docker
	echo "fi" >> backup-database-docker
	echo "" >> backup-database-docker
}

function restore_database_shell() {
	touch restore-database-docker
	echo "#!/bin/bash" >> restore-database-docker
	echo "" >> restore-database-docker
	echo "echo -e \"Command Created by Munis\"" >> restore-database-docker
	echo "echo -e \"Restore Posgresql Database\"" >> restore-database-docker
	echo "" >> restore-database-docker
	echo "if [[ \"\$1\" && \"\$2\" ]]; then" >> restore-database-docker
	echo "   cat \$1 | docker exec -i \$2 psql -U postgres" >> restore-database-docker
	echo "   echo -e \"Successfuly Restored from dump file name: \$(tput setaf 2 && tput bold)\$1 \"" >> restore-database-docker
	echo "else" >> restore-database-docker
	echo "   echo -e \"Please Select Dump Sql file and Container name for example \"" >> restore-database-docker
	echo "   echo -e \"restore-database-docker dump_07-04-2018_22_29_33.sql postgres-db \"" >> restore-database-docker
	echo "fi" >> restore-database-docker
	echo "" >> restore-database-docker
}



if [ "$EUID" -ne 0 ]; then
	# If not root user
	if [ -d $LOCAL_COMMAND_DIRECTORY ]; then
		cd $LOCAL_COMMAND_DIRECTORY
		rm -rf ./*-docker
		build_docker_shell
		down_docker_shell
		connect_docker_shell
		dangling_remove_docker_shell
		restart_docker_shell
		migrate_docker_shell
		logs_docker_shell
		backup_database_shell
		restore_database_shell
		chmod +x *
	else
		cd ~
		mkdir .local
		cd .local/
		mkdir bin/
		cd $LOCAL_COMMAND_DIRECTORY
		build_docker_shell
		down_docker_shell
		connect_docker_shell
		dangling_remove_docker_shell
		restart_docker_shell
		migrate_docker_shell
		logs_docker_shell
		backup_database_shell
		restore_database_shell
		chmod +x *
	fi
else
	# if user is root
	cd $ROOT_COMMAND_DIRECTORY
	rm -rf ./*-docker
	build_docker_shell
	down_docker_shell
	connect_docker_shell
	dangling_remove_docker_shell
	restart_docker_shell
	migrate_docker_shell
	logs_docker_shell
	backup_database_shell
	restore_database_shell
	chmod +x build-docker
	chmod +x down-docker
	chmod +x connect-docker
	chmod +x dangling-remove-docker
	chmod +x restart-docker
	chmod +x migrate-docker
	chmod +x logs-docker
	chmod +x backup-database-docker
	chmod +x restore-database-docker
fi

cd $WORKING_DIRECTRY

rm -rf install.sh

$SHELL



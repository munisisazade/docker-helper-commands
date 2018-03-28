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


if [ "$EUID" -ne 0 ]; then
	# If not root user
	if [ -d $LOCAL_COMMAND_DIRECTORY ]; then
		cd $LOCAL_COMMAND_DIRECTORY
		build_docker_shell
		down_docker_shell
		connect_docker_shell
		dangling_remove_docker_shell
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
		chmod +x *
	fi
else
	# if user is root
	cd $ROOT_COMMAND_DIRECTORY
	build_docker_shell
	down_docker_shell
	connect_docker_shell
	dangling_remove_docker_shell
	chmod +x build-docker
	chmod +x down-docker
	chmod +x connect-docker
	chmod +x dangling-remove-docker
fi


$SHELL

cd $WORKING_DIRECTRY
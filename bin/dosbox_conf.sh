#!/bin/bash
# Script to configure Dosbox no Ubuntu Server 22.04 LTS 64 bits
#
# Autor: Leandro Luiz
# email: lls.homeoffice@gmail.com

dosbox_install()
{
	
	echo "Installing"
	sudo apt -y install ${APP_NAME}
	
}

dosbox_config()
{
	
	DIR_CONF=".${APP_NAME}"
	FILE_CONF="dosbox-0.74-3.conf"
	
	if [ ! -d ~/${DIR_CONF} ]; then
	
		mkdir -pv ~/${DIR_CONF}
	
	fi
	
	if [ ! -f ~/${DIR_CONF}/${FILE_CONF}.bak ]; then
	
		if [ -f ~/${DIR_CONF}/${FILE_CONF} ]; then
	
			cp -fv ~/${DIR_CONF}/${FILE_CONF} ~/${DIR_CONF}/${FILE_CONF}.bak
				
		fi
			
	fi
	
	cp -fv conf/${FILE_CONF} ~/${DIR_CONF}/${FILE_CONF}
	
	if [ ! -d "lls" ]; then

	    tar -xvf lls-dataflex.tar.gz

	fi 

}

dosbox_run()
{
	
	${APP_NAME}
	
}

USER=$(whoami)

if [ ${USER} = "root" ]; then
    
    echo "Usuario root não permitido!"
    
    exit 1;
    
fi

APP_NAME="dosbox"

case "$1" in
	install)
		dosbox_install
		;;
	config)
		dosbox_config
		;;
	run)
		dosbox_run
		;;
	all)
		dosbox_install
		dosbox_config
		dosbox_run
		;;
	*)
		echo "Use: $0 {all|install|config|run}"
		exit 1
		;;
esac

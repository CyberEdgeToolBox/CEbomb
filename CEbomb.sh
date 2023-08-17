#!/bin/bash

detect_distro() {
    if [[ "$OSTYPE" == linux-android* ]]; then
            distro="termux"
    fi

    if [ -z "$distro" ]; then
        distro=$(ls /etc | awk 'match($0, "(.+?)[-_](?:release|version)", groups) {if(groups[1] != "os") {print groups[1]}}')
    fi

    if [ -z "$distro" ]; then
        if [ -f "/etc/os-release" ]; then
            distro="$(source /etc/os-release && echo $ID)"
        elif [ "$OSTYPE" == "darwin" ]; then
            distro="darwin"
        else 
            distro="invalid"
        fi
    fi
}

pause() {
    read -n1 -r -p "PRESS ANY KEY TO CONTINUE..." key
apt-get update
apt-get upgrade
apt-get install python    
}
banner() {
    clear
    echo -e "\e[1;31m"
    if ! [ -x "$(command -v figlet)" ]; then
        echo 'INTRODUCING CEBOMB'
    else
        figlet CEBOMB
    fi
    if ! [ -x "$(command -v toilet)" ]; then
        echo -e "\e[4;34m This Bomber Was Created By \e[1;32mCyberEdge \e[0m"
     else
        echo -e "\e[1;34mCreated By \e[1;34m"
        figlet CyberEdge
    printf "\033[1;93m[\033[1;77m::\033[1;93m]	    \033[1;92m   Code by : \033[1;97m  CyberEdge \033[1;93m[\033[1;77m::\033[1;93m]"
	printf "\n\033[1;93m[\033[1;77m::\033[1;93m]	\033[1;92mModify code by : \033[1;97m  CyberEdge \033[1;93m[\033[1;77m::\033[1;93m]\n"
    echo " "
    echo " "
    echo -e            *Requirements:*

    echo -e '\033[1;36m'            ➡️ '\033[1;31m'100 MB Data*
    echo -e '\033[1;36m'            ➡️ '\033[1;31m'200 MB Storage*
    echo -e '\033[1;36m'            ➡️ '\033[1;31m'No Root*
    echo -e '\033[1;36m'            ➡️ '\033[1;31m'Data Connection*
    fi
    
    echo " "

}

init_environ(){
    declare -A backends; backends=(
        ["arch"]="pacman -S --noconfirm"
        ["debian"]="apt-get -y install"
        ["ubuntu"]="apt -y install"
        ["termux"]="apt -y install"
        ["fedora"]="yum -y install"
        ["redhat"]="yum -y install"
        ["SuSE"]="zypper -n install"
        ["sles"]="zypper -n install"
        ["darwin"]="brew install"
        ["alpine"]="apk add"
    )

    INSTALL="${backends[$distro]}"

    if [ "$distro" == "termux" ]; then
        PYTHON="python"
        SUDO=""
    else
        PYTHON="python3"
        SUDO="sudo"
    fi
    PIP="$PYTHON -m pip"
}

install_deps(){
    
    packages=(openssl git $PYTHON $PYTHON-pip figlet toilet)
    if [ -n "$INSTALL" ];then
        for package in ${packages[@]}; do
            $SUDO $INSTALL $package
        done
        $PIP install -r requirements.txt
    else
        echo "We could not install dependencies."
        echo "Please make sure you have git, python3, pip3 and requirements installed."
        echo "Then you can execute bomber.py ."
        exit
    fi
}

banner
pause
detect_distro
init_environ
if [ -f .update ];then
    echo "All Requirements Found...."
else
    echo 'Installing Requirements....'
    echo .
    echo .
    install_deps
    echo This Script Was Made By CyberEdge > .update
    echo 'Requirements Installed....'
    pause
fi
while :
do
    banner
    
    echo " "
    echo -e "'\033[1;31m                           ⫸ Coded by\033[1;32m CyberEdge\033[1;31m ⫷\033[0m"
    echo -e "'\033[1;31m                               ⫸\033[1;33m Cyber Edge\033[1;31m ⫷\033[0m"
    echo 
    echo -e "'\033[1;36m############################# \033[1;32m [Features] \033[1;36m ###################################"
echo " "
echo " "
echo -e " \033[1;31m                         ➡️ \033[1;33m  [1️⃣] Sms bombing"
echo -e " \033[1;31m                         ➡️ \033[1;33m  [2️⃣] exit"
echo " "
echo " "
echo -e "\033[1;36m ############################## \033[1;32m [SELECT] \033[1;36m ####################################"
echo " "
  

    read ch
    clear
    if [ $ch -eq 1 ];then
        $PYTHON bomber.py --sms
        exit
    elif [ $ch -eq 2 ];then
        banner
        exit
    else
        echo -e "\e[4;32m Invalid Input !!! \e[0m"
        pause
    fi
done

#!/bin/bash

source_file_update(){

echo "更新系统源中...."
echo "deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse" > /etc/apt/sources.list

echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse" >> /etc/apt/sources.list

echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse" >>  /etc/apt/sources.list

echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse" >> /etc/apt/sources.list

echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse" >> /etc/apt/sources.list

echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse" >> /etc/apt/sources.list

echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list

echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse" >>  /etc/apt/sources.list

echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse" >>  /etc/apt/sources.list

echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse" >>   /etc/apt/sources.list
apt-get update
}

check_install(){
	if [ `whoami` == "root" ];then
	echo "Ok."
else 
	echo "因源文件普通用户不可写,请以root用户执行脚本. Example: sudo ./Linux_install.sh"
	exit
fi
}

Basic_environment(){
	echo "基础环境安装中...."
apt-get install net-tools -y

apt-get install wget -y

apt-get install curl -y

apt-get install vim -y 

apt-get install openssh-server -y 

apt-get install python3 -y

apt-get install curl -y

apt-get install python -y

apt-get install git -y

}

docker_install(){
	apt-get remove docker docker-engine docker.io

apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common

#
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"

#
apt-get update

echo "开始安装Docker"

apt-get install docker-ce  -y 

apt-get install python3-pip  -y 

apt-get install nmap -y

apt-get install sed -y

python3 -m pip install docker-compose

apt  install docker-compose  -y

service docker start
}


vulhub_install(){
	cd $HOME
	echo "安装vulnhub环境中..."

	git clone https://github.com/vulhub/vulhub

}

msf_install(){
	echo "msf安装中...."
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall
}

powershell(){
	cd $HOME
	mkdir Powershell
	cd Powershell
	git clone https://github.com/PowerShellMafia/PowerSploit.git

}

empire_install(){
	cd $HOME
	echo "安装Empire.."
	git clone https://github.com/EmpireProject/Empire.git
	cd Empire
	./setup/install.sh 
}

neiwang(){
	cd $HOME
	mkdir 内网渗透
	cd 内网渗透
	git clone https://github.com/idlefire/ew.git
}

zsh_install(){
	cd $HOME
	apt-get install zsh -y
	chsh -s /bin/zsh
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
	sed 's/plugins=(git)/plugins=(git zsh-autosuggestions)/' ~/.zshrc  > test.QAQ
	cat test.QAQ > .zshrc
	rm test.QAQ
	source .zshrc
}

call_back(){
	if [ $1 = "help" ]
		then
			

			echo "举例子: ./xxx.sh zsh_install，或者全部安装 ./xxx.sh，目前支持有
					source_file_update
					Basic_environment
					docker_install
					vulhub_install
					msf_install
					powershell
					empire_install
					neiwang
					zsh_install
					sqlmap_install"
		else
			$1
		fi
}

sqlmap_install(){
	cd $HOME
	git clone https://github.com/sqlmapproject/sqlmap.git
}

main(){
	if [ $# == 0 ]
	then
		check_install
		cd $HOME
		source_file_update
		Basic_environment
		docker_install
		vulhub_install
		msf_install
		powershell
		empire_install
		neiwang
		zsh_install
		sqlmap_install
	else
		for Setup in $@;do
			call_back $Setup
		done
	fi


}

main $*
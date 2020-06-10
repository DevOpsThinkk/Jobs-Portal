#!/usr/bin/env bash
# Install PostgreSQL, Python, PIP, Git and Python Virtual Environment in Ubuntu 18.04
# Install Jq

sudo apt-get --yes update \
&& sudo apt-get --yes install jq \
&& sudo apt-get --yes install unzip || log "ERROR: Failed update" $?

log()
{
         exit_code=$2
		 if [ -z $2 ]; then
		    exit_code=0
		 fi

		 echo "[`date '+%Y-%m-%d %T'`]:" $1
		 if [ ${exit_code} -ne "0" ]; then
		   exit ${exit_code}
		 fi
}

# Download and setup required softwares for Job Portal application
PostgreSQL_setup(){
    log "INFO: Start Postgresql Installation"
        echo "======================================================================================"
    apt install postgresql postgresql-contrib -y
}
Python38_setup(){
    log "INFO: Start Python 3.8 Installation"
        echo "======================================================================================"
    apt install software-properties-common -y
    add-apt-repository ppa:deadsnakes/ppa -y
    apt install python3.8 -y 
}

Git_setup(){
    log "INFO: Start Git Installation"
        echo "======================================================================================"
    apt install git-all -y
}

pip3_setup(){
    log "INFO: Start PIP3 Installation"
    apt-get install python3-pip apache2 libapache2-mod-wsgi-py3 -y || log  "ERROR: Python Installation failed" $?
    log "INFO: Python Installation Complete"
}

Create_directory(){
    log "INFO: Create a directory called django"
    mkdir /home/django/ 
    cd /home/django || log  "ERROR: django directory creation error" $?
    log "INFO: django directory creation Complete"
}

python_virtualenv_setup(){
    log "INFO: Start Python Virtual environment setup"
    pip3 install virtualenv
    virtualenv myprojectenv || log  "ERROR: Python virtual environment setup failed" $?
    log "INFO: Python virtual environment setup Complete"

}

#VERIFY ABOVE INSTALLED APPLICATIONS    

verify_install(){
 
    log "INFO: VERIFY PostgreSQL version"
    psql --version || log "ERROR: PostgreSQL verification failed" $?

    log "INFO: VERIFY Python"
    python3.8 --version || log "ERROR: Python 3.8 verification failed" $?

    log "INFO: VERIFY GITS"
    git --version || log "ERROR: GIT verification failed" $?

    log "INFO: VERIFY PYTHON PIP3"
    pip3 --version || log "ERROR: kubectl verification failed" $?

    log "INFO: VERIFY libapache2-mod-wsgi-py3"
    dpkg -l | grep wsgi || log "ERROR: libapache2-mod-wsgi-py3 verification failed" $?

    log "INFO: VERIFY APACHE"
    apache2 -v  || log "ERROR: Apache verification failed" $?

    log "INFO: Validation Successful !!!"

}
echo "======================================================================================"
PostgreSQL_setup
sleep 2
echo "======================================================================================"
Python38_setup
sleep 2
echo "======================================================================================"
Git_setup
sleep 2
echo "======================================================================================"
pip3_setup
sleep 2
echo "======================================================================================"
Create_directory
sleep 2
echo "======================================================================================"
python_virtualenv_setup
sleep 2
echo "======================================================================================"
verify_install
echo "======================================================================================"
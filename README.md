## Django Job Portal

### Implimentation steps:
```
./prerequisite.sh
cd /home/django
git clone https://github.com/DevOpsGH/Jobs-Portal.git
mv Jobs-Portal myproject
source /home/django/myprojectenv/bin/activate
cd myproject
pip3 install -r requirements.txt
```

### Apache Server Configuration
```
cd /etc/apache2/sites-available
vi 000-default.conf
```
##### Replace below content and save :wq! 
```
<VirtualHost *:80>
    ServerAdmin webmaster@example.com
    DocumentRoot /home/django/myproject
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
    Alias /static /home/django/myproject/static
    <Directory /home/django/myproject/static>
        Require all granted
    </Directory>
    <Directory /home/django/myproject/jobs>
        <Files wsgi.py>
        Require all granted
        </Files>
    </Directory>
    WSGIDaemonProcess myproject python-path=/home/django/myproject python-home=/home/django/myprojectenv
    WSGIProcessGroup myproject
    WSGIScriptAlias / /home/django/myproject/jobs/wsgi.py
</VirtualHost>
```

### Edit Apache 2 configuration file and make allow
```
cd /etc/apache2
vi apache2.conf
```
### Grant required permissions and restart the services
```
cd /home/django/myproject
chmod 664 db.sqlite3
chown :www-data db.sqlite3
chown :www-data jobs
chmod  a+x /home/django/myproject/jobs/wsgi.py
chmod  a+x /home/django/myproject/jobs/urls.py
chmod  a+x /home/django/myproject/jobs/settings.py

service apache2 restart
```
### Check error log if you encounter any issue
```
cd /var/log/apache2/
tail -150 /var/log/apache2/error.log
tail -150 /var/log/apache2/access.log
tail -150 /var/log/apache2/other_vhosts_access.log
```
### Workarounds for 500 error
```
##### Removed python2 version libraries
apt-get remove libapache2-mod-python libapache2-mod-wsgi
##### Installed Python 3 version libraries
apt-get install libapache2-mod-wsgi-py3
```

#### An open source online job portal.

Live: [Demo](https://django-portal.herokuapp.com/) or [Second Demo](http://jobs.manjurulhoque.com/)

Used Tech Stack

1. Django
2. Sqlite

### Screenshots

## Home page
<img src="screenshots/one.png" height="800">

## Add new position as employer
<img src="screenshots/two.png" height="800">

## Job details
<img src="screenshots/three.png" height="800">

Show your support by 🌟 the project!!
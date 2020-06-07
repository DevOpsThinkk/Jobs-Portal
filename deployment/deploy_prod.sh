#!/bin/sh

ssh root@192.168.33.40 <<EOF
  cd /var/www/html/jobsproject/jobsportal/
  git pull
  cd /var/www/html/jobsproject/
  source jobsenv/bin/activate
  cd jobsportal/
  cat requirements.txt | xargs -n 1 pip install
  python manage.py migrate
  sudo systemctl restart gunicorn
  exit
EOF

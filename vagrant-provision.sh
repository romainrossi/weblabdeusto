#!/usr/bin/env bash

# weblabdeusto
echo 'Provisioning from script'

echo 'export MAVEN_OPTS=-Xmx512m
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
export JDK_HOME=$JAVA_HOME
export PATH=$JAVA_HOME/bin:$PATH' > ~/.javarc
. ~/.javarc

export SHARED_DIR='/weblabdeusto/'
export ENV_NAME='weblab'

. "/etc/bash_completion.d/virtualenvwrapper"
if [ ! -d /home/vagrant/.virtualenvs/$ENV_NAME ]; then
  mkvirtualenv $ENV_NAME
  workon $ENV_NAME
  cd $SHARED_DIR
  python setup.py install
  echo "workon weblab" >> /home/vagrant/.bashrc

  echo 'Finishing provisioning' $ENV_NAME
else
  echo 'Ignoring existing default environment' $ENV_NAME
fi


if [ ! -d /home/vagrant/$WEBLAB_INSTANCE ]; then
  weblab-admin create $WEBLAB_INSTANCE \
    --not-interactive -v \
    --cores=1 \
    --lab-copies=1 \
    --dummy-copies=5 \
    --db-engine=mysql \
    --db-name=$DB_NAME \
    --db-host=$DB_HOST \
    --db-port=$DB_PORT \
    --db-user=$DB_USER \
    --db-passwd=$DB_PASSWORD \
    --coordination-engine=redis \
    --coordination-redis-db=$REDIS_DB \
    --coordination-redis-passwd=$REDIS_PASSWORD \
    --coordination-redis-port=$REDIS_PORT \
    --admin-user=$WEBLAB_ADMIN \
    --admin-name=$WEBLAB_ADMIN \
    --admin-password=$WEBLAB_ADMIN_PASSWORD \
    --admin-mail=$WEBLAB_ADMIN_EMAIL \
    --http-server-port=8000 \
    --system-identifier=rooc1 \



fi

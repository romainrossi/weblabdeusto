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

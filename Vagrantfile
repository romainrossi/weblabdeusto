# -*- mode: ruby -*-
# vi: set ft=ruby :

# A script to provision dependencies
$provision_script = <<SCRIPT
#!/bin/bash

# disable apt cache and compress apt lists to reduce disk footprint
echo 'Dir::Cache { srcpkgcache ""; pkgcache ""; }' > /etc/apt/apt.conf.d/02nocache
echo 'Acquire::GzipIndexes "true"; Acquire::CompressionTypes::Order:: "gz";' > /etc/apt/apt.conf.d/02compress-indexes

apt-get update -q
apt-get install -q -y curl git
apt-get install -q -y build-essential libxml2-dev libxslt1-dev libsqlite3-dev libmysqlclient-dev libsasl2-dev libmaxminddb-dev libyaml-dev
apt-get install -q -y python-dev python-pip python-virtualenv virtualenvwrapper
apt-get install -q -y openjdk-8-jdk maven ant

# Configuration
export WEBLAB_INSTANCE=rooc
export WEBLAB_ADMIN=rooc
export WEBLAB_ADMIN_PASSWORD=coor
export WEBLAB_ADMIN_EMAIL="admin@rooc.esigelec.fr"

export DB_HOST=localhost
export DB_PORT=3306
export DB_NAME=weblab
export DB_USER=weblab
export DB_PASSWORD=mysqlpass

export REDIS_DB=4
export REDIS_PASSWORD=redispass
export REDIS_PORT=6379

export SHARED_DIR='/weblabdeusto/'
export ENV_NAME='weblab'

# MySQL
apt-get install -q -y mariadb-server
mariadb -e "CREATE OR REPLACE USER $DB_USER@'localhost' IDENTIFIED BY '$DB_PASSWORD'"
mariadb -e "CREATE DATABASE $DB_NAME"
mariadb -e "GRANT ALL PRIVILEGES ON *.* TO $DB_USER@localhost"
#mariadb -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@localhost"
mariadb -e "FLUSH PRIVILEGES"


# Redis server
apt-get install -q -y redis-server
redis-cli config set requirepass $REDIS_PASSWORD

# Apache
apt-get install -q -y apache2

# program provisioning
#su - vagrant $SHARED_DIR/vagrant-provision.sh
SCRIPT

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/bionic64"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 8000, host: 8000
  config.vm.network :forwarded_port, guest: 3306, host: 8033
  for i in 10000..10100
    config.vm.network :forwarded_port, guest: i, host: i
  end
  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder ".", "/weblabdeusto", :mount_options => ["dmode=777,fmode=666"]

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider :virtualbox do |vb, override|
    # Don't boot with headless mode
    # vb.gui = true

    override.vm.provision :shell, :inline => $provision_script

    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "1024"]

    # Customize CPU number
    # vb.customize ["modifyvm", :id, "--cpus", $vm_cpus]

    # This setting makes it so that network access from inside the vagrant guest
    # is able to resolve DNS using the hosts VPN connection.
    # v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

end

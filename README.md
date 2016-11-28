Instalar paquetes requeridos.
==============================

apt-get install git
apt-get install ruby ruby-dev
apt-get install build-essential
apt-get install postgresql-9.6 postgresql-client

Configure postgresql user.
==========================

Edit /etc/postgresql/9.4/main/pg_hba.conf and change auth method to trust.

# vi /etc/postgresql/9.4/main/pg_hba.conf

Restart postgres
# /etc/init.d/postgresql restart

Instalar las gemas.
===================

gem install dep
cd tripviajes
dep install

Configurar Postgres.
====================

# adduser tripuser
# su - postgres
# createuser tripuser
# createdb -O tripuser tripviajes

Production
==========

Install phusion passenger = nginx
----------------------------------

https://github.com/gramos/ruby-passenger-tutorial


sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo apt-get install -y apt-transport-https ca-certificates


sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger jessie main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update


sudo apt-get install -y nginx-extras passenger

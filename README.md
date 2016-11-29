Instalar paquetes requeridos.
==============================

```
apt-get install git
apt-get install ruby ruby-dev
apt-get install build-essential
apt-get install postgresql-9.6 postgresql-client
```

Instalar dependecias para correr los test con webkit
=====================================================

```apt-get install qt5-default libqt5webkit5-dev \ 
   gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x```

Configurar Postgres.
====================

Agrego el usuario en linux "tripuser"

``` 
#=>  adduser tripuser
#=> passwd tripuser
#=> su - postgres
```

Agrego el usuario tripuser desde postgresql

```$ psql template1```

```template1=# CREATE USER tripuser WITH PASSWORD 'myPassword';```

```template1=# CREATE DATABASE tripviajes;```

```template1=# GRANT ALL PRIVILEGES ON DATABASE tripviajes to tripuser;```

Edit /etc/postgresql/9.4/main/pg_hba.conf and change auth method to trust.

```# vi /etc/postgresql/9.4/main/pg_hba.conf```

Restart postgres

```# /etc/init.d/postgresql restart```

Instalar las gemas.
===================

```
gem install dep
cd tripviajes
dep install
```

Crear env.sh editar y completar con datos reales.
=================================================

```cp env.example.sh env.sh```

Production
==========

Install phusion passenger = nginx
----------------------------------

https://github.com/gramos/ruby-passenger-tutorial


```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo apt-get install -y apt-transport-https ca-certificates

sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger jessie main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update

sudo apt-get install -y nginx-extras passenger
```


Instalar paquetes requeridos.
==============================

apt-get install ruby
gem install dep
cd tripviajes
dep install
apt-get install postgresql postgresql-client

Configurar Postgres.
====================

# su - postgres
# createuser tripuser
# createdb -O tripuser tripviajes

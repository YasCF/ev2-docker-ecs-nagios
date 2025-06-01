#!/bin/bash

# Iniciar Apache y Nagios
service apache2 start
/usr/local/nagios/bin/nagios /usr/local/nagios/etc/nagios.cfg

# Mantener el contenedor en ejecución
tail -f /var/log/apache2/access.log

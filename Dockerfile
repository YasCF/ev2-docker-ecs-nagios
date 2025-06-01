# Imagen base
FROM Ubuntu:2204

# Variables de entorno para evitar prompts interactivos
ENV DEBIAN_FRONTEND=noninteractive

# Actualización e instalación de dependencias
RUN apt-get update && \
    apt-get install -y \
    apache2 \
    php \
    libapache2-mod-php \
    build-essential \
    libgd-dev \
    unzip \
    curl \
    wget \
    libssl-dev \
    openssl \
    daemon \
    libtool \
    gcc \
    make \
    autoconf \
    bc \
    gawk \
    dc \
    gettext && \
    apt-get clean

# Crear usuario y grupo nagios
RUN useradd nagios && \
    groupadd nagcmd && \
    usermod -a -G nagcmd nagios && \
    usermod -a -G nagcmd www-data

# Descargar y compilar Nagios Core
WORKDIR /opt
RUN wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz && \
    tar xzf nagios-4.4.6.tar.gz && \
    cd nagios-4.4.6 && \
    ./configure --with-command-group=nagcmd && \
    make all && \
    make install && \
    make install-init && \
    make install-commandmode && \
    make install-config && \
    make install-webconf

# Configurar contraseña web
RUN htpasswd -b -c /usr/local/nagios/etc/htpasswd.users nagiosadmin nagiosadmin

# Habilitar módulos de Apache
RUN a2enmod rewrite cgi

# Agregar script de arranque
COPY start_nagios.sh /start_nagios.sh
RUN chmod +x /start_nagios.sh

# Exponer el puerto 80
EXPOSE 80

# Comando por defecto al iniciar el contenedor
CMD ["/start_nagios.sh"]

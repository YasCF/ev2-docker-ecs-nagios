FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias
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
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

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

# Crear usuario web
RUN htpasswd -b -c /usr/local/nagios/etc/htpasswd.users nagiosadmin nagiosadmin

# Activar módulos Apache
RUN a2enmod rewrite cgi

# Copiar script de arranque
COPY start_nagios.sh /start_nagios.sh
RUN chmod +x /start_nagios.sh

# Exponer puerto HTTP
EXPOSE 80

# Iniciar Nagios
CMD ["/start_nagios.sh"]

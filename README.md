# EV2 - Nagios con Docker (Ubuntu 22.04)

Este repositorio corresponde a la Evaluación Parcial 2 (EV2) de la asignatura **Tecnologías de Virtualización**.  
Aquí se implementa una solución de monitoreo basada en **Nagios Core** usando **Docker**, preparada para ejecución **local** y futura integración con **AWS ECS, ECR y EFS**.

## 📦 Tecnologías utilizadas

- Docker
- Ubuntu 22.04
- Nagios Core 4.4.6
- Apache2 + PHP
- Git & GitHub

## 📁 Estructura del repositorio

ev2-docker-ecs-nagios/

├── Dockerfile

└── start_nagios.sh

---

## 🧪 Uso local del proyecto con Docker

### 1. Clonar el repositorio

git clone https://github.com/YasCF/ev2-docker-ecs-nagios.git
cd ev2-docker-ecs-nagios

## 2. Dar permisos de ejecución al script

chmod +x start_nagios.sh

## 3. Construir la imagen Docker

docker build -t ev2_nagios-docker-ecs .

## 4. Ejecutar el contenedor

docker run -d -p 8080:80 --name nagios ev2_nagios-docker-ecs

## 5. Acceder a Nagios

Abre tu navegador y ve a:

- http://localhost:8080

### Credenciales:

- Usuario: nagiosadmin
- Contraseña: nagiosadmin

## 🛠️ Descripción técnica

- La imagen está basada en ubuntu:22.04.
- Nagios se instala y configura para ejecutarse automáticamente junto con Apache.
- Se incluye un script de arranque start_nagios.sh que inicia los servicios requeridos.
- El puerto 80 del contenedor se expone localmente en el puerto 8080.

## 👤 Autor

Yasna Candia
Duoc UC – Ingeniería en Infraestructura y Plataformas Tecnológicas
Evaluación Parcial 2 – DIY7111: Tecnologías de Virtualización


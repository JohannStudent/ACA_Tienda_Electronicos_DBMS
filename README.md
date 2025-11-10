🧩 Proyecto de Integración Tecnológica

Este proyecto fue desarrollado como parte de las actividades académicas de la Corporación Unificada Nacional de Educación Superior (CUN) en el programa de Ingeniería de Sistemas, y forma parte del portafolio profesional de Johann Casallas, desarrollador de integración en el Banco Popular.

Su propósito es demostrar la aplicación práctica de conceptos de integración de sistemas, arquitectura de software y buenas prácticas de desarrollo en entornos empresariales reales.

🚀 Características Principales

Desarrollo de servicios de integración mediante APIs REST y SOAP.

Comunicación con sistemas internos a través de IBM MQ.

Implementación en C# / .NET con soporte para Oracle y SQL Server.

Arquitectura modular basada en capas: Core, API, Infrastructure.

Cumplimiento de estándares de seguridad y control de acceso.

Pruebas con herramientas profesionales: Postman, SoapUI y MQ Explorer.

🧱 Arquitectura General

Representación conceptual de la arquitectura de integración:

[Cliente o Sistema Externo] --> [API REST] --> [Servicio de Integración] --> [MQ / DB / Sistema Interno]


Capas funcionales:

API Layer: interfaz de comunicación HTTP(S).

Integration Core: lógica de negocio, transformación y enrutamiento de datos.

Data Layer: persistencia en Oracle/SQL Server.

⚙️ Requisitos Previos

.NET SDK: versión 6.0 o superior

Git Bash: versión actualizada

IBM Integration Toolkit: 10.0.0.23

Postman / SoapUI: para pruebas funcionales

Oracle Database / SQL Server: conexión activa

MQ Explorer: para gestión de colas

🔧 Instalación y Configuración

Clonar el repositorio desde GitHub:

git clone https://github.com/johanncasallas/proyecto-integracion.git
cd proyecto-integracion


Configurar variables de entorno:

DB_CONNECTION=Data Source=...;
MQ_HOST=host.ejemplo.com
MQ_PORT=1414


Restaurar dependencias:

dotnet restore


Ejecutar el servicio localmente:

dotnet run

🧪 Ejecución de Pruebas

Ejecutar pruebas unitarias:

dotnet test


Generar reporte de cobertura:

dotnet test /p:CollectCoverage=true

📂 Estructura del Proyecto
/src
  /Core
  /API
  /Infrastructure
/tests
  /UnitTests
/docs
README.md

📦 Despliegue

Construir el proyecto:

dotnet publish -c Release -o out


Desplegar en el entorno de integración (servidor o contenedor Docker).

🔒 Seguridad

Uso de autenticación con tokens JWT.

Cifrado de credenciales y datos sensibles.

Validación de entrada y sanitización de parámetros.

Control de acceso basado en roles (RBAC).

📘 Ejemplo de Endpoint
Endpoint: POST /api/transactions/sync

Descripción:
Sincroniza una transacción entre sistemas internos y externos.

Request:

{
  "transactionId": "TX123456",
  "amount": 250000,
  "currency": "COP",
  "sourceSystem": "CoreBanking"
}


Response:

{
  "status": "SUCCESS",
  "message": "Transacción sincronizada correctamente"
}

👥 Autor

Johann Casallas
Estudiante de Ingeniería de Sistemas - CUN
Desarrollador de Integración en Banco Popular
📧 casallasbecerrajohann@gmail.com

🧾 Licencia

Proyecto desarrollado con fines académicos y demostrativos.
Todos los derechos reservados © 2025 Johann Casallas.
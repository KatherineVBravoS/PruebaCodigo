# PruebaCodigo

Este repositorio utiliza un pipeline de **CI/CD** gestionado por **GitHub Actions**. A continuación, se describe el flujo de trabajo del pipeline y el flujo de trabajo en **Git** para realizar cambios en este proyecto.

## Flujo del Pipeline

El pipeline se ejecuta automáticamente cuando se realiza un `push` a la rama `master`. El proceso consta de dos etapas principales: **Build** y **Deploy**.

### 1. Etapa de Construcción (Build)

La etapa de **Build** tiene como objetivo configurar el entorno y preparar la infraestructura para el despliegue de la función Lambda y otros recursos en AWS.

#### Pasos del Pipeline:

- **Checkout repository**: Se clona el repositorio para obtener la versión más reciente del código fuente.
- **Manually set up AWS credentials**: Se configuran las credenciales de AWS para permitir la interacción con los servicios de AWS, como S3, Lambda, y API Gateway.
- **Set up Terraform**: Se instala y configura Terraform para gestionar la infraestructura como código.
- **Terraform init**: Se inicializa el entorno de Terraform y se descargan los proveedores necesarios.
- **Terraform plan**: Muestra los cambios que se realizarán en la infraestructura, pero no los aplica aún.
- **Terraform apply -auto-approve**: Aplica los cambios a la infraestructura y evita la confirmacion manual.

### 2. Etapa de Despliegue (Deploy)

La etapa de **Deploy** realiza el despliegue de la función Lambda y la API Gateway en AWS.

#### Pasos del Pipeline:

- **Checkout repository**: Se clona nuevamente el repositorio para asegurarse de que los últimos cambios están disponibles.
- **Install dependencies**: Se instalan dependencias necesarias, como `awscli` y `boto3`, para interactuar con los servicios de AWS.
- **Check if lambda.zip exists**: Se verifica que el archivo `lambda.zip` (que contiene el código de la función Lambda) exista en el repositorio.
- **Configure AWS Credentials**: Se configuran las credenciales de AWS de manera segura, utilizando secretos de GitHub para garantizar que no se filtren credenciales sensibles.
- **Debug AWS CLI Credentials**: Se realiza una prueba para verificar que las credenciales de AWS están configuradas correctamente.
- **Upload to S3**: El archivo `lambda.zip` se sube al bucket de S3 para su posterior uso en la actualización de la función Lambda.
- **Deploy Lambda and API Gateway**: Se actualiza el código de la función Lambda con el nuevo paquete y se despliega la API Gateway.
- **Test API Gateway**: Se realiza una solicitud de prueba `GET` a la API Gateway para asegurarse de que la función Lambda esté funcionando correctamente.

## Flujo de Git

El flujo de trabajo en Git sigue un ciclo basado en ramas para garantizar que los cambios se gestionen de manera organizada.

### Pasos en el Flujo de Git:

1. **Crear una nueva rama**:
   - Se recomienda trabajar en ramas separadas para cada nueva funcionalidad o tarea. Por ejemplo: `feature/nueva-funcionalidad`.
  
2. **Realizar cambios y commits**:
   - Realiza tus cambios y haz commits con mensajes claros que describan lo que se ha cambiado. Asegúrate de seguir las mejores prácticas para escribir mensajes de commit descriptivos.

3. **Crear una Pull Request (PR)**:
   - Una vez que los cambios estén listos, abre una *Pull Request* (PR) hacia la rama `master`. Esto permitirá revisar los cambios antes de integrarlos.

4. **Revisión y fusión**:
   - El equipo revisará la PR. Si está aprobado, se fusionará con la rama `master`.

5. **Push a `master`**:
   - Cuando la PR se fusiona, haz un `push` de los cambios a la rama `master`. Esto activará automáticamente el pipeline de CI/CD.

6. **Despliegue automático**:
   - El pipeline de CI/CD se activará automáticamente al realizar un `push` a la rama `master`. Esto iniciará el despliegue de la función Lambda y la API Gateway.

Este flujo asegura que los cambios en el código y en la infraestructura se gestionen de manera automática y controlada, lo que facilita la integración continua y el despliegue continuo (CI/CD) de la aplicación.

## Requisitos

- **AWS CLI** configurado y con acceso a tu cuenta de AWS.
- **Terraform** para la gestión de infraestructura en AWS.
- **GitHub Actions** para la automatización de CI/CD.

---

**Nota**: Este proyecto utiliza la infraestructura de AWS, incluyendo Lambda, S3 y API Gateway. Asegúrate de tener los permisos necesarios para crear o modificar estos recursos en tu cuenta de AWS.
**Nota2**: Si se revisan los commit, encontraran los ultimos donde el pasó sin problemas. El ultimo que se subio dará error ya que el S3 ya se encuentra creado al igual que el rol `lambda_execution_role`.


# Proyecto Solsi App
### Descripción
La Solsi App es una aplicación educativa interactiva diseñada para ayudar a los usuarios a aprender y controlar dispositivos conectados a través de Firebase y ESP32. 
La app incluye diversas pantallas interactivas, donde el usuario puede interactuar con imágenes y escuchar audios, activando servomotores a través de Firebase Realtime Database.

### Funcionalidades:
Reproduce audios y controla servomotores mediante Firebase.

Interacción con imágenes que activan eventos de audio y control de servos.

Ventanas emergentes con tutoriales y enlaces a videos de ayuda.

Navegación entre pantallas (Inicio, Puzzle, Instrucciones).

### Requisitos
Para ejecutar este proyecto, necesitas tener instaladas las siguientes herramientas:
- Flutter

- Dart

- Firebase

## Android Studio (para emular o ejecutar en dispositivo)

Configuración:
1. **Clonar el repositorio:** Primero, clona este repositorio en tu máquina local:
```
git clone https://github.com/tu-usuario/solsi-app.git
cd solsi-app
```


2. **Instalar dependencias:** En la terminal, navega a la carpeta raíz del proyecto y ejecuta:
```
flutter pub get
```

3. **Configuración de Firebase:**
Asegúrate de que Firebase esté configurado en tu proyecto de Flutter. Sigue los pasos de la documentación de Firebase para Flutter en Configurar Firebase en Flutter.

4. **Configuración de Firebase Realtime Database:**
Asegúrate de tener habilitada la base de datos en tiempo real en tu proyecto Firebase. La base de datos debe contener una ruta como /SERVO/servo1 para controlar el servomotor.

5. **Configuración de ESP32**
El ESP32 debe estar configurado para recibir señales de Firebase. Asegúrate de que esté escuchando cambios en la ruta /SERVO/servo1 para controlar el servomotor.

6. **Configurar la red Wi-Fi**
Si estás utilizando Wi-Fi, puedes configurar el ESP32 para conectarse a cualquier red utilizando un portal cautivo (WiFiManager) o configurarlo manualmente en el código.

## Ejecución

Una vez que hayas configurado el proyecto, puedes ejecutarlo en tu dispositivo o emulador:
```
flutter run
```

## Estructura del Proyecto
lib/: Contiene los archivos principales de código fuente de la app.

indications.dart: Pantalla de indicaciones o instrucciones.

initiate.dart: Pantalla de inicio con un botón que activa un audio y un servomotor.

puzzle.dart: Pantalla de rompecabezas con interacción de imágenes que activan audios y controlan servomotores.

assets/: Contiene todos los archivos multimedia utilizados en la app (imágenes, audios).

pantalla0.png: Imagen de fondo de la pantalla de inicio.

nido.png, cueva.png, tableroS.png, despedida.png: Imágenes interactivas utilizadas en la pantalla de rompecabezas.

Archivos de audio como nidoc.mp3, cuevae.mp3, Tablero.mp3, Despedida.mp3.


## Funcionalidades Clave

- Pantalla de Inicio (Initiate)
Muestra una imagen con un botón central interactivo que, al presionarlo, reproduce un audio y activa un servomotor conectado a Firebase.

- Una ventana emergente que muestra un tutorial de la aplicación y un enlace a un video tutorial en YouTube.

- Pantalla de Rompecabezas (Puzzle)
Permite al usuario interactuar con imágenes (por ejemplo, nido.png y cueva.png) que, al tocarlas, reproducen audios y activan servos a través de Firebase.

- Una pila de imágenes con posiciones específicas (por ejemplo, un tablero y una despedida).

- Navegación entre pantallas (hacia atrás a las instrucciones o hacia la pantalla de inicio).

- Reproducción de Audio y Control de Servo:
  1. Al tocar cualquier imagen, se activa la reproducción de un archivo de audio asociado y se controla el servomotor conectado a Firebase.
  2. Se detiene cualquier audio anterior antes de comenzar a reproducir el nuevo.

- Ventana Emergente: Al hacer clic en el ícono de tutorial, se muestra una ventana emergente con información y un enlace a un video tutorial.

## Contribuciones
Si deseas contribuir a este proyecto, por favor sigue estos pasos:

Haz un fork del repositorio.

Crea una rama nueva (git checkout -b feature/nueva-funcionalidad).

Realiza los cambios y confirma (git commit -am 'Agrega nueva funcionalidad').

Sube los cambios (git push origin feature/nueva-funcionalidad).

Crea un pull request.


## Dependencias
Para que el proyecto funcione correctamente, necesitas agregar las siguientes dependencias en tu archivo pubspec.yaml. Estas son las librerías necesarias:

1. **Dependencias en pubspec:** Abre el archivo pubspec.yaml y agrega las siguientes líneas en la sección de dependencias:
```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.14.0
  firebase_database: ^10.0.4
  audioplayers: ^0.20.0
  url_launcher: ^6.1.5
```
Estas dependencias son para las siguientes funcionalidades:

- firebase_core: Para inicializar Firebase en el proyecto.

- firebase_database: Para interactuar con Firebase Realtime Database y controlar el servomotor.

- audioplayers: Para reproducir archivos de audio desde la app.

- url_launcher: Para abrir enlaces en el navegador, como el tutorial en YouTube.

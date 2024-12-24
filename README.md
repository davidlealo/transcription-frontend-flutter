# Transcripción de Audio

Este proyecto es una aplicación Flutter para la carga y transcripción de archivos de audio. Permite a los usuarios cargar archivos de audio y obtener transcripciones gracias a un backend desarrollado en FastAPI.

## Características

- Selección de archivos de audio locales.
- Envío del archivo a un servidor backend.
- Visualización de la transcripción devuelta por el backend.

## Tecnologías utilizadas

- **Flutter**: Framework para el desarrollo de la aplicación móvil.
- **FastAPI**: Framework para el backend de procesamiento de audio.
- **File Picker**: Librería para la selección de archivos locales.
- **HTTP**: Para la comunicación entre frontend y backend.

## Configuración del proyecto

### Prerrequisitos

Asegúrate de tener instalados los siguientes programas:

- Flutter SDK: [Instalación](https://flutter.dev/docs/get-started/install)
- Dart SDK: Incluido con Flutter.
- Backend de FastAPI: Disponible en el repositorio [transcription-backend-fastapi](https://github.com/davidlealo/transcription-backend-fastapi).

### Instalación

1. Clona este repositorio:

   ```bash
   git clone https://github.com/davidlealo/transcription-frontend-flutter.git
   cd transcription-frontend-flutter
   ```

2. Instala las dependencias:

   ```bash
   flutter pub get
   ```

3. Configura el backend siguiendo las instrucciones en su [repositorio](https://github.com/davidlealo/transcription-backend-fastapi).

4. Asegúrate de que el backend esté corriendo en `http://localhost:8000` o actualiza la URL en el archivo `main.dart` si es diferente.

5. Ejecuta la aplicación:

   ```bash
   flutter run
   ```

## Uso

1. Selecciona un archivo de audio usando el botón **Seleccionar archivo de audio**.
2. Presiona el botón **Enviar al backend** para cargar el archivo al servidor.
3. Visualiza la transcripción devuelta por el servidor.

## Pruebas

Este proyecto incluye pruebas unitarias para validar el flujo principal de la aplicación. Para ejecutarlas, utiliza el comando:

```bash
flutter test
```

## Contacto

Si tienes preguntas, sugerencias o algún problema con el proyecto, no dudes en contactarme:

- **Email**: davidlealo@gmail.com
- **GitHub**: [https://github.com/davidlealo](https://github.com/davidlealo)
- **LinkedIn**: [https://www.linkedin.com/in/davidlealo/](https://www.linkedin.com/in/davidlealo/)

## Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.


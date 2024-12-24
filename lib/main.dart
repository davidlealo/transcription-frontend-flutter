import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transcripción de Audio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AudioUploaderScreen(),
    );
  }
}

class AudioUploaderScreen extends StatefulWidget {
  const AudioUploaderScreen({Key? key}) : super(key: key);

  @override
  _AudioUploaderScreenState createState() => _AudioUploaderScreenState();
}

class _AudioUploaderScreenState extends State<AudioUploaderScreen> {
  Uint8List? _selectedFileBytes;
  String? _selectedFileName;
  String? _transcriptionResult;

  // Método para seleccionar un archivo de audio
  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'm4a'], // Extensiones soportadas
    );

    if (result != null) {
      setState(() {
        _selectedFileBytes = result.files.single.bytes;
        _selectedFileName = result.files.single.name;
      });
    }
  }

  // Método para enviar el archivo al backend
  Future<void> _uploadFile() async {
    if (_selectedFileBytes == null || _selectedFileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor selecciona un archivo primero')),
      );
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost:8000/process_audio/'), // Cambia al endpoint de tu backend
    );
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        _selectedFileBytes!,
        filename: _selectedFileName,
      ),
    );

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      setState(() {
        _transcriptionResult = responseBody;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al procesar el archivo: ${response.reasonPhrase}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transcripción de Audio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _selectFile,
              child: const Text('Seleccionar archivo de audio'),
            ),
            const SizedBox(height: 16.0),
            if (_selectedFileName != null)
              Text(
                'Archivo seleccionado: $_selectedFileName',
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _uploadFile,
              child: const Text('Enviar al backend'),
            ),
            const SizedBox(height: 32.0),
            if (_transcriptionResult != null)
              Text(
                'Resultado de la transcripción:\n$_transcriptionResult',
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}

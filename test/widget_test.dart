import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:transcription_frontend_flutter/main.dart';

void main() {
  testWidgets('Prueba de flujo de carga y transcripción de audio', (WidgetTester tester) async {
    // Construye la aplicación
    await tester.pumpWidget(const MyApp());

    // Verifica que el título está presente
    expect(find.text('Transcripción de Audio'), findsOneWidget);

    // Encuentra el botón para seleccionar archivo y simula un tap
    final selectFileButton = find.text('Seleccionar archivo de audio');
    expect(selectFileButton, findsOneWidget);

    // Simula un tap en el botón de seleccionar archivo
    await tester.tap(selectFileButton);
    await tester.pump();

    // Como FilePicker no puede ser testeado directamente, simularemos el estado posterior
    // Actualiza el estado para reflejar un archivo seleccionado
    await tester.runAsync(() async {
      // Accede al estado del widget y simula el archivo seleccionado
      final state = tester.state<_AudioUploaderScreenState>(find.byType(AudioUploaderScreen));
      state.setState(() {
        state._selectedFileName = 'archivo_prueba.mp3';
        state._selectedFileBytes = Uint8List.fromList([0, 1, 2, 3]); // Bytes simulados
      });
    });
    await tester.pump();

    // Verifica que el archivo seleccionado se muestra
    expect(find.text('Archivo seleccionado: archivo_prueba.mp3'), findsOneWidget);

    // Encuentra el botón para enviar archivo y simula un tap
    final uploadFileButton = find.text('Enviar al backend');
    expect(uploadFileButton, findsOneWidget);

    // Simula un tap en el botón de enviar
    await tester.tap(uploadFileButton);
    await tester.pump();

    // Como la lógica del backend no puede probarse directamente, simula el resultado esperado
    await tester.runAsync(() async {
      final state = tester.state<_AudioUploaderScreenState>(find.byType(AudioUploaderScreen));
      state.setState(() {
        state._transcriptionResult = 'Texto transcrito simulado';
      });
    });
    await tester.pump();

    // Verifica que el resultado de la transcripción se muestra correctamente
    expect(find.textContaining('Resultado de la transcripción: Texto transcrito simulado'), findsOneWidget);
  });
}

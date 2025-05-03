import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'package:solsi_app/pages/initiate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ocultar barra de notificaciones y navegación
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // Fijar orientación a solo vertical
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Inicialización de Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Solsi",
      home: const Initiate(),
    );
  }
}




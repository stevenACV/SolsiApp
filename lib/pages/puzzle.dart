import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:solsi_app/pages/indications.dart';
import 'package:solsi_app/pages/initiate.dart';
import 'package:url_launcher/url_launcher.dart';


class Puzzle extends StatefulWidget {
  const Puzzle({super.key});

  @override
  State<Puzzle> createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> {
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void dispose() {
    audioPlayer.stop();
    FirebaseDatabase.instance.ref("/SERVO/servo1").set(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color(0xFF64BAF9);
    
    return Scaffold(
      ///////////////////////////////////////////////////////////////////////
      backgroundColor: backgroundColor,
      ///////////////////////////////////////////////////////////////////////
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Imagen que contiene texto (en el extremo izquierdo)
            Image.asset(
              "assets/parte2.png",
              height: 27,
            ),
            
            // Botón con imagen tutorial (en el extremo derecho)
            GestureDetector(
              onTap: () => mostrarVentanaEmergente(context),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset("assets/tutorial.png"),
              ),
            ),
          ],
        ),
      ),
  
      
      
      ///////////////////////////////////////////////////////////////////////
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Fila de dos imágenes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      reproducirAudioYControlarServo('audios/nidoc.mp3');
                    },
                    child: Image.asset('assets/nido.png'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      reproducirAudioYControlarServo('audios/cuevae.mp3');
                    },
                    child: Image.asset('assets/cueva.png'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Imagen de fondo con imágenes encima
            Stack(
              alignment: Alignment.center,
              children: [
                // Imagen rectangular con letras
                Image.asset(
                  'assets/imageF1.png',
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: 400,
                ),

                // Column con las dos imágenes superpuestas
                Positioned(
                  top: 100, // Ajusta esto para no tapar letras
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          reproducirAudioYControlarServo('audios/Tablero.mp3');
                        },
                        child: Image.asset(
                          'assets/tableroS.png',
                          width: 220,
                          height: 120,
                        ),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          reproducirAudioYControlarServo('audios/Despedida.mp3');
                        },
                        child: Image.asset(
                          'assets/despedida.png',
                          width: 220,
                          height: 120,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      ///////////////////////////////////////////////////////////////////////
      // PIE DE PÁGINA
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Imagen a la izquierda envuelta en GestureDetector
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Indications()),
                );
              },
              child: Image.asset(
                'assets/retroceder.png',
                height: 70,
                width: 70,
              ),
            ),

            // Texto + imagen a la derecha
            Row(
              children: [
                const Text(
                  "Volver al",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Initiate()),
                    );
                  },
                  child: Transform.translate(
                    offset: const Offset(0, -24),
                    child: Image.asset(
                      'assets/volverinicio.png',
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void mostrarVentanaEmergente(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF64BAF9), // Color de fondo personalizado
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.zero,
          content: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Center(
                      child: Text(
                        'Video Tutorial',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'En el siguiente video se mostrará un tutorial sobre el uso de las ventanas de la app.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () async {
                        const url = 'https://www.youtube.com/watch?v=j9UKmIYllHQ'; // Reemplaza con tu URL real
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                        }
                      },
                      child: const Text(
                        'Tutorial App Solsi',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop(); // Cierra la ventana
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void reproducirAudioYControlarServo(String rutaAudio) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("/SERVO/servo1");

    try {
      await ref.set(true); // Activar servo

      await audioPlayer.stop(); // Detener cualquier audio anterior
      await audioPlayer.play(AssetSource(rutaAudio)); // Reproducir nuevo audio

      await audioPlayer.onPlayerComplete.first; // Esperar a que termine

      await ref.set(false); // Apagar servo

    } catch (e) {
      print("Error en reproducirAudioYControlarServo: $e");
    }
  }



}
import 'package:flutter/material.dart';
import 'package:solsi_app/pages/initiate.dart';
import 'package:solsi_app/pages/puzzle.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_database/firebase_database.dart';


class Indications extends StatefulWidget {
  const Indications({super.key});

  @override
  State<Indications> createState() => _IndicationsState();
}

class _IndicationsState extends State<Indications> {
  final AudioPlayer _audioPlayer = AudioPlayer(); // Crea un controlador de audio
  final DatabaseReference _servoRef = FirebaseDatabase.instance.ref('SERVO/servo1');

  // Método para reproducir el audio de acuerdo a la imagen tocada
  void playAudio(String audioPath) async {
    await _audioPlayer.play(AssetSource(audioPath));  // Reproduce el audio desde los assets
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    FirebaseDatabase.instance.ref("/SERVO/servo1").set(false);
    super.dispose();
  }

  // Método para mostrar video tutorial
  void mostrarVentanaEmergente(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF9938F), // Color de fondo personalizado
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


  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color(0xFFF9938F);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Imagen que contiene texto (en el extremo izquierdo)
            Image.asset(
              "assets/parte1.png",
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
      
      body: Column(
        children: [
          const SizedBox(height: 35),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.55,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 5 imágenes en columna
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            playAudio('audios/Muylejos.mp3');
                          },
                          child: Image.asset('assets/muylejos.png', height: 30),
                        ),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {
                            playAudio('audios/Lejos.mp3');
                          },
                          child: Image.asset('assets/lejos.png', height: 30),
                        ),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {
                            playAudio('audios/aunpaso.mp3');
                          },
                          child: Image.asset('assets/aunpaso.png', height: 30),
                        ),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {
                            playAudio('audios/Cerca.mp3');
                          },
                          child: Image.asset('assets/cerca.png', height: 30),
                        ),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {
                            playAudio('audios/Muycerca.mp3');
                          },
                          child: Image.asset('assets/muycerca.png', height: 30),
                        ),
                      ],
                    ),
                    const SizedBox(height: 54),
                    // 3 imágenes en fila
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              playAudio('audios/aizquierda.mp3');
                            },
                            child: Image.asset('assets/izquierda.png', height: 26),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              playAudio('audios/Busca.mp3');
                            },
                            child: Image.asset('assets/busca.png', height: 36),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              playAudio('audios/aderecha.mp3');
                            },
                            child: Image.asset('assets/derecha.png', height: 26),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    // 1 imagen centrada
                    GestureDetector(
                      onTap: () {
                        playAudio('audios/Abajo.mp3');
                      },
                      child: Image.asset('assets/abajo.png', height: 30),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          // Imagen adicional centrada fuera del recuadro
          GestureDetector(
            onTap: () async {
              await _servoRef.set(true); // Activar el servo
              await _audioPlayer.play(AssetSource('audios/Huevoen.mp3')); // Reproducir audio
              _audioPlayer.onPlayerComplete.listen((event) async {
                await _servoRef.set(false); // Desactivar el servo al terminar el audio
              });
            },
            child: Center(
              child: Image.asset('assets/huevoEnc.png', height: 80),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: backgroundColor,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Initiate()),
                  );
                },
                child: Transform.scale(
                  scale: 2,
                  child: Image.asset('assets/retroceder.png', height: 40),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Puzzle()),
                  );
                },
                child: Transform.scale(
                  scale: 2,
                  child: Image.asset('assets/avanzar.png', height: 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


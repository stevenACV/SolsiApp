import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'indications.dart';

class Initiate extends StatefulWidget {
  const Initiate({super.key});

  @override
  State<Initiate> createState() => _InitiateState();
}

class _InitiateState extends State<Initiate> with TickerProviderStateMixin {
  final AudioPlayer _player = AudioPlayer();
  bool _imagenPrecargada = false;

  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_imagenPrecargada) {
      precacheImage(
        const AssetImage("assets/pantalla0.png"),
        context,
      );
      _imagenPrecargada = true;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    FirebaseDatabase.instance.ref("/SERVO/servo1").set(false);
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo adaptada
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/pantalla0.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Imagen en la esquina superior derecha
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.04,
                right: screenWidth * 0.05,
              ),
              child: GestureDetector(
                onTap: () => mostrarVentanaEmergente(context),
                child: Image.asset(
                  "assets/tutorial.png",
                  width: screenWidth * 0.1,
                  height: screenWidth * 0.1,
                ),
              ),
            ),
          ),
          // Botón central con animación
          Center(
            child: GestureDetector(
              onTap: () => _irAPaginaYReproducirAudio(context),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: SizedBox(
                      width: screenWidth * 0.5,
                      height: screenWidth * 0.5,
                      child: child,
                    ),
                  );
                },
                child: Image.asset("assets/inicio.png"),
              ),
            ),
          ),
          // Imagen como pie de página
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              "assets/credito.png",
              fit: BoxFit.cover,
              height: screenHeight * 0.12,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  void mostrarVentanaEmergente(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 245, 243, 227),
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
                        const url = 'https://www.youtube.com/watch?v=j9UKmIYllHQ';
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
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _irAPaginaYReproducirAudio(BuildContext context) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("/SERVO/servo1");
    try {
      await ref.set(true);
      await _player.play(AssetSource('audios/Iniciar.mp3'));
      await _player.onPlayerComplete.first;
      await ref.set(false);
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Indications()),
        );
      }
    } catch (e) {
      print("Error en _irAPaginaYReproducirAudio: $e");
    }
  }
}
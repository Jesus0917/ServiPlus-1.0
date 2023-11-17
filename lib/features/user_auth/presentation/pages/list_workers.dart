import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/WorkerProfileScreen.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class ListaTrabajadores extends StatelessWidget {
  final List<Map<String, String>> workers;
  final String serviceName;

  const ListaTrabajadores(this.workers, {super.key, required this.serviceName});

  void _navigateToSettingsScreen(BuildContext context) {}

  void _navigateToAccountScreen(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'Personas Disponibles - $serviceName',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WorkerProfileScreen(
                            serviceName: 'Juan Pérez')));
              },
              child: const SizedBox(
                width: 500, // Ancho personalizado
                child: WorkerContainer(
                  name: 'Juan Pérez',
                  price: '\$20000/hora', 
                  imagePath: '',
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WorkerProfileScreen(
                            serviceName: 'María López')));
              },
              child: const SizedBox(
                width: 500, // Ancho personalizado
                child: WorkerContainer(
                  name: 'María López',
                  price: '\$18000/hora',
                  imagePath: '',
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WorkerProfileScreen(
                            serviceName: 'Carlos Sánchez')));
              },
              child: const SizedBox(
                width: 500, // Ancho personalizado
                child: WorkerContainer(
                  name: 'Carlos Sánchez',
                  price: '\$25000/hora',
                  imagePath: '',
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WorkerProfileScreen(
                            serviceName: 'Ana Martínez')));
              },
              child: const SizedBox(
                width: 500, // Ancho personalizado
                child: WorkerContainer(
                  name: 'Ana Martínez',
                  price: '\$22000/hora',
                  imagePath: '',
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WorkerProfileScreen(
                            serviceName: 'Roberto Rodríguez')));
              },
              child: const SizedBox(
                width: 500, // Ancho personalizado
                child: WorkerContainer(
                  name: 'Roberto Rodríguez',
                  price: '\$30000/hora',
                  imagePath: '',
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WorkerProfileScreen(
                            serviceName: 'Sara Gómez')));
              },
              child: const SizedBox(
                width: 500, // Ancho personalizado
                child: WorkerContainer(
                  name: 'Sara Gómez',
                  price: '\$18000/hora',
                  imagePath: '',
                ),
              ),
            ),
            // Add more contenedores aquí
          ],
        ),
      ),
    );
  }
}
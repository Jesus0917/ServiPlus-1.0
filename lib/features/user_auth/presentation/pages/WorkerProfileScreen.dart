import 'dart:ui';

import 'package:flutter/material.dart';
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

class WorkerProfileScreen extends StatelessWidget {
  const WorkerProfileScreen({super.key, required this.serviceName});

  final String serviceName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white.withAlpha(200),
        elevation: 0,
        title: const Center(
          child: Text(
            'Perfil Del Trabajador',
            style: TextStyle(
              fontSize: 27.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Circular space for profile picture
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage('https://picsum.photos/200/300'),
              ),
              const SizedBox(height: 20.0),

              // Worker's name
              Text(
                'Nombre: Juan Pérez',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10.0),

              // Worker's profession
              Text(
                'Profesión: Plomero',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10.0),

              // Worker's phone number
              Text(
                'Número de teléfono: +57 3113489344',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10.0),

              // Worker's price
              Text(
                'Precio x Hora: \$15.000',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}

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
  const WorkerProfileScreen({Key? key, required this.serviceName}) : super(key: key);

  final String serviceName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Text(
            'Trabajador',
            style: TextStyle(
              fontSize: 20.0,
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
              Text(
                'Nombre: $serviceName',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              // ... otros widgets en el perfil del trabajador
            ],
          ),
        ),
      ),
    );
  }
}

class ListaTrabajadores extends StatelessWidget {
  final List<Map<String, String>> workers;

  const ListaTrabajadores(this.workers, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ... otras configuraciones de la barra de aplicaciones
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int index = 0; index < workers.length; index++)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkerProfileScreen(
                        serviceName: workers[index]['name'] ?? '',
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  width: 500,
                  child: WorkerContainer(
                    name: workers[index]['name'] ?? '',
                    price: workers[index]['price'] ?? '',
                    imagePath: workers[index]['imagePath'] ?? '',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
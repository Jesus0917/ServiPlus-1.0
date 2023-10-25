import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProfileScreen(), // Establece ProfileScreen como la pantalla de inicio de la aplicación.
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'), // Título de la barra de aplicación.
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Contenido del perfil del usuario.

            // Imagen de perfil del usuario.
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const CircleAvatar(
                radius: 80.0,
                backgroundImage: AssetImage('assets/profile_image.jpg'),
              ),
            ),

            // Campos de entrada de texto para el perfil del usuario.
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Teléfono',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Precio',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Descripción',
              ),
            ),

            // Botón "Aceptar" (debe proporcionarse la lógica).
            ElevatedButton(
              onPressed: () {
                // Lógica para el botón de "Aceptar".
              },
              child: const Text('Aceptar'),
            ),

            // Fila de botones de acción.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Lógica para el botón "Llamar".
                  },
                  child: const Text('Llamar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para el botón "Chat".
                  },
                  child: const Text('Chat'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para el botón "Ofrecer".
                  },
                  child: const Text('Ofrecer'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para el botón "Otros".
                  },
                  child: const Text('Otros'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(), // Establece ProfileScreen como la pantalla de inicio de la aplicación.
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'), // Título de la barra de aplicación.
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Contenido del perfil del usuario.

            // Imagen de perfil del usuario.
            Container(
              padding: EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 80.0,
                backgroundImage: AssetImage('assets/profile_image.jpg'),
              ),
            ),

            // Campos de entrada de texto para el perfil del usuario.
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Teléfono',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Precio',
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Descripción',
              ),
            ),

            // Botón "Aceptar" (debe proporcionarse la lógica).
            ElevatedButton(
              onPressed: () {
                // Lógica para el botón de "Aceptar".
              },
              child: Text('Aceptar'),
            ),

            // Fila de botones de acción.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Lógica para el botón "Llamar".
                  },
                  child: Text('Llamar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para el botón "Chat".
                  },
                  child: Text('Chat'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para el botón "Ofrecer".
                  },
                  child: Text('Ofrecer'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para el botón "Otros".
                  },
                  child: Text('Otros'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

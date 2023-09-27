import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de Inicio'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          '¡Bienvenido! Has iniciado sesión exitosamente.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

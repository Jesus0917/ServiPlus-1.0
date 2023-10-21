import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(MyApp()); // Inicia la aplicación Flutter creando una instancia de MyApp y la muestra en la pantalla.
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MaterialColor miMaterialColorPersonalizado = MaterialColor(
      0xFF1F3DD0, // Define un color personalizado que se usará como color principal de la aplicación.
      <int, Color>{
        50: miColorPersonalizado.withOpacity(0.1),
        100: miColorPersonalizado.withOpacity(0.2),
        200: miColorPersonalizado.withOpacity(0.3),
        300: miColorPersonalizado.withOpacity(0.4),
        400: miColorPersonalizado.withOpacity(0.5),
        500: miColorPersonalizado,
        600: miColorPersonalizado.withOpacity(0.6),
        700: miColorPersonalizado.withOpacity(0.7),
        800: miColorPersonalizado.withOpacity(0.8),
        900: miColorPersonalizado.withOpacity(0.9), // Define tonos de color para sombras más claras.
        // Define tonos de color con diferentes niveles de opacidad para diversos usos.
      },
    );

    return MaterialApp(
      title: 'ServiPlus', // Establece el título de la aplicación.
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de depuración en la esquina derecha superior.
      theme: ThemeData(
        primarySwatch: miMaterialColorPersonalizado, // Asigna el color personalizado como color principal de la aplicación.
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent, // Define el fondo de la barra de navegación como transparente.
        ),
      ),
      home:
          AuthScreen(), // Esto inicia directamente en la pantalla de inicio de sesión al cargar la aplicación.
      routes: {
        '/register': (context) => RegisterScreen(), // Define una ruta para la pantalla de registro.
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MaterialColor miMaterialColorPersonalizado = MaterialColor(
      0xFF1F3DD0,
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
        900: miColorPersonalizado.withOpacity(0.9),
      },
    );

    return MaterialApp(
      title: 'ServiPlus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: miMaterialColorPersonalizado,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
        ),
      ),
      home:
          AuthScreen(), // Esto inicia directamente en la pantalla de inicio de sesión
      routes: {
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}

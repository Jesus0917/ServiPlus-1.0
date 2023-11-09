import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:flutter_application_1/features/app/splash_screen/splash_screen.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/home_page.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/login_page.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDCK_0HnLL4nI2WIY6e-zy6pa4iQ58T52g",
        appId: "1:683084536873:android:be02ed8a64bb1adc4b5038",
        messagingSenderId: "683084536873",
        projectId: "serviplus-bedd4",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Color miColorPersonalizado = Color(0xFF1F3DD0);

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
        900: miColorPersonalizado.withOpacity(0.9), // Define tonos de color para sombras más claras.
        // Define tonos de color con diferentes niveles de opacidad para diversos usos.
      },
    );

    return StreamProvider<User?>.value(
      value: FirebaseAuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'ServiPlus',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: miMaterialColorPersonalizado,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
          ),
        ),
        home: SplashScreen(
          child: LoginPage(),
        ),
        routes: {
          '/': (context) => SplashScreen(
            child: LoginPage(),
          ),
          '/login': (context) => LoginPage(),
          '/signUp': (context) => SignUpPage(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}

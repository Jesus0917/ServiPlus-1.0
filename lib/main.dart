import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

Color miColorPersonalizado = Color(0xFF1F3DD0);
//prueba git
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
      home: AuthScreen(), // Cambiado de initialRoute a home
      routes: {
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isRegistered = false;
  bool isLoggedIn = false;
  String? registeredEmail;
  String? registeredPassword;

  void register() async {
    final result = await Navigator.pushNamed(context, '/register');
    if (result != null && result is Map<String, String>) {
      setState(() {
        isRegistered = true;
        registeredEmail = result['email'];
        registeredPassword = result['password'];
      });
    }
  }

  void login() {
    if (isRegistered) {
      final enteredEmail = emailController.text;
      final enteredPassword = passwordController.text;

      if (enteredEmail == registeredEmail && enteredPassword == registeredPassword) {
        setState(() {
          isLoggedIn = true;
        });

        // Navegar a la HomeScreen después del inicio de sesión exitoso
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error de inicio de sesión'),
              content: Text('Credenciales incorrectas. Verifica tu correo y contraseña.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cerrar'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error de inicio de sesión'),
            content: Text('Debes registrarte antes de iniciar sesión.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cerrar'),
              ),
            ],
          );
        },
      );
    }
  }

  void openFacebookPage() async {
    const url = 'https://www.facebook.com';
    if (await launchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw Exception('No se pudo abrir la URL $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      return HomeScreen(); // Cambiado para mostrar HomeScreen después de iniciar sesión
    } else {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBar(
            title: Text(
              'Serviplus',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: openFacebookPage,
                child: Image.asset('assets/logo.jpg', width: 200, height: 200),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Correo Electrónico',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: login,
                    child: Text('Iniciar Sesión'),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              TextButton(
                onPressed: register,
                child: Text('¿No tienes una cuenta? Regístrate aquí.'),
              ),
              buildSignInButtons(),
            ],
          ),
        ),
      );
    }
  }

  Widget buildSignInButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildGoogleSignInButton(),
        SizedBox(width: 16.0),
        buildFacebookSignInButton(),
      ],
    );
  }

  ElevatedButton buildGoogleSignInButton() {
    return ElevatedButton(
      onPressed: () {
        // Lógica para iniciar sesión con Google
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        elevation: MaterialStateProperty.all<double>(0),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.all(0),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(
              color: Colors.black.withOpacity(0.2),
              width: 1.0,
            ),
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Image.asset('assets/logogoogle.png', width: 24, height: 24),
      ),
    );
  }

  ElevatedButton buildFacebookSignInButton() {
    return ElevatedButton(
      onPressed: () {
        // Lógica para iniciar sesión con Google
      }, // Botón de Facebook sin acción
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        elevation: MaterialStateProperty.all<double>(0),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.all(0),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(
              color: Colors.black.withOpacity(0.2),
              width: 1.0,
            ),
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Image.asset('assets/logofacebook.png', width: 24, height: 24),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController registerEmailController = TextEditingController();
    TextEditingController registerPasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: registerEmailController,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: registerPasswordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final registerEmail = registerEmailController.text;
                final registerPassword = registerPasswordController.text;
                final result = {'email': registerEmail, 'password': registerPassword};
                Navigator.pop(context, result);
              },
              child: Text('Registrarse'),
            ),
            SizedBox(height: 16.0),
            Text('O inicia sesión con:'),
            buildSignInButtons(),
          ],
        ),
      ),
    );
  }

  Widget buildSignInButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildGoogleSignInButton(),
        SizedBox(width: 16.0),
        buildFacebookSignInButton(),
      ],
    );
  }

  ElevatedButton buildGoogleSignInButton() {
    return ElevatedButton(
      onPressed: () {
        // Lógica para iniciar sesión con Google
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        elevation: MaterialStateProperty.all<double>(0),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.all(0),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(
              color: Colors.black.withOpacity(0.2),
              width: 1.0,
            ),
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Image.asset('assets/logogoogle.png', width: 24, height: 24),
      ),
    );
  }

  ElevatedButton buildFacebookSignInButton() {
    return ElevatedButton(
      onPressed: null, // Botón de Facebook sin acción
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        elevation: MaterialStateProperty.all<double>(0),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.all(0),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: BorderSide(
              color: Colors.black.withOpacity(0.2),
              width: 1.0,
            ),
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Image.asset('assets/logofacebook.png', width: 24, height: 24),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          '¡Bienvenido a la pantalla de inicio!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

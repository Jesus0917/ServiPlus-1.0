import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
Color miColorPersonalizado = const Color(0xFF1F3DD0);
class SplashScreen extends StatefulWidget {
  final Widget? child;

  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => widget.child!),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bienvenido a ServiPlus",
              style: TextStyle(
                color: Color(0xFF1F3DD0),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            _buildAnimatedText(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedText() {
    return SpinKitFadingCube(
      color: Color(0xFF1F3DD0),
      size: 40.0,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SplashScreen(
      child: YourNextScreen(),
    ),
  ));
}

class YourNextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Next Screen"),
      ),
      body: Center(
        child: Text("Welcome to Serviplus!"),
      ),
    );
  }
}

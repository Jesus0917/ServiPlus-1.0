import 'dart:ui';
import 'package:flutter_application_1/features/user_auth/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/home_page.dart';

class ProfilePage extends StatefulWidget {
  final Widget? child;

  const ProfilePage({super.key, this.child});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: ClipRect(child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
            )),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white.withAlpha(200),
          elevation: 0,
          title: const Center(
            child: Text(
              'Cuenta',
              style: TextStyle(
                fontSize: 27.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: GNav(
          backgroundColor: Colors.white,
          activeColor: Colors.white,
          gap: 8,
          tabBackgroundColor: const Color(0xFF1F3DD0),
          padding: const EdgeInsets.all(16),
          tabs: const [
            GButton(
              icon: LineIcons.home,
              text: 'Inicio',
            ),
            GButton(
              icon: LineIcons.user,
              text: 'Cuenta',
            ),
            GButton(
              icon: LineIcons.wrench,
              text: 'Ajustes',
            ),
          ],
          onTabChange: (index) {
            if (index == 0) {
              Navigator.pop(context);
            } else if (index == 1) {
              _navigateToAccountScreen(context);
            } else if (index == 2) {
              _navigateToSettingsScreen(context);
            }
          },
        ),
      ),
    );  
  }
  // Método para navegar a la página de inicio (Home)
  void _navigateToHomeScreen() {
    showDialog(
      context: context,
      builder: (context) {
        return const HomePage();
      },
    );
  }

  // Método para mostrar la pantalla de cuenta como un diálogo
  void _navigateToAccountScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const ProfilePage();
      },
    );
  }

  // Método para mostrar la pantalla de configuración como un diálogo
  void _navigateToSettingsScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const SettingsDialog();
      },
    );
  }
}
class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Configuración',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildSettingItem('Notificaciones', Icons.notifications),
            _buildSettingItem('Privacidad', Icons.lock),
            _buildSettingItem('Preferencias', Icons.settings),
            _buildSettingItem('Acerca de', Icons.info),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Cerrar el diálogo de configuración
              },
              child: const Text('Cerrar'),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir un elemento de configuración
  Widget _buildSettingItem(String label, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        // Implementar acciones para cada elemento de configuración si es necesario
      },
    );
  }
}


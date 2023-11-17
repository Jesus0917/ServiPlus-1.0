import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/list_workers.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

Color miColorPersonalizado = const Color(0xFF1F3DD0);

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomePage> {
  String title = 'Serviplus';
  final List<Map<String, String>> services = [
    {'name': 'Plomero', 'image': 'assets/plomero.png'},
    {'name': 'Aseador', 'image': 'assets/limpiador.png'},
    {'name': 'Profesor', 'image': 'assets/profesor.png'},
    {'name': 'Electricista', 'image': 'assets/rayo.png'},
    {'name': 'Mecanico', 'image': 'assets/reparando.png'},
    {'name': 'Paseador', 'image': 'assets/caminando-con-perro.png'},
    {'name': 'Cocinero', 'image': 'assets/cocinero.png'},
    {'name': 'Lavanderia', 'image': 'assets/servicio-de-lavanderia.png'},
  ];

  int _currentIndex = 0;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCurrentScreen(),
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
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
              setState(() {
                _currentIndex = index;
                if (index == 0) {
                  _navigateToHomeScreen();
                  title = 'Serviplus';
                } else if (index == 1) {
                  _navigateToAccountScreen(context);
                  title = 'Cuenta';
                } else if (index == 2) {
                  _navigateToSettingsScreen(context);
                  title = 'Ajustes';
                }
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentScreen() {
    if (_currentIndex == 0) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 50.0,
          mainAxisSpacing: 50.0,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return ServiceCard(
            serviceName: services[index]['name'] ?? '',
            imagePath: services[index]['image'] ?? '', workers: [],
          );
        },
      );
    } else if (_currentIndex == 1) {
      return const Center(
        child: AccountScreen(),
      );
    } else {
      return Center(
        child: SettingsScreen(
          notificationsEnabled: notificationsEnabled,
          onNotificationToggle: _toggleNotifications,
        ),
      );
    }
  }

  void _navigateToHomeScreen() {}

  void _navigateToAccountScreen(BuildContext context) {}

  void _navigateToSettingsScreen(BuildContext context) {}

  void _toggleNotifications(bool newStatus) {
    setState(() {
      notificationsEnabled = newStatus;
    });
  }
}

class ServiceCard extends StatelessWidget {
  final String serviceName;
  final String imagePath;
  final List<Map<String, String>> workers;

  const ServiceCard({
    Key? key,
    required this.serviceName,
    required this.imagePath,
    required this.workers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(200.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListaTrabajadores(workers, serviceName: '',),
              ),
            );
          },
          child: Container(
            height: 120,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  height: 60,
                ),
                const SizedBox(height: 5.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    serviceName,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WorkerContainer extends StatelessWidget {
  final String name;
  final String price;
  final String imagePath;

  const WorkerContainer({
    Key? key,
    required this.name,
    required this.price,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(imagePath),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key});

  Future<Map<String, dynamic>> getUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String profileImageUrl = await getProfileImageUrl(user.email!);

        return {
          'username': 'Nombre de Usuario',
          'email': user.email ?? 'correo@example.com',
          'profileImage': profileImageUrl,
        };
      }
    } catch (error) {
      print('Error getting user data: $error');
    }

    return {
      'username': 'Nombre de Usuario',
      'email': 'correo@example.com',
      'profileImage': 'URL_DE_LA_IMAGEN_POR_DEFECTO',
    };
  }

  Future<String> getProfileImageUrl(String userEmail) async {
    try {
      final storage = FirebaseStorage.instance;
      final ref = storage.ref().child('profile_images/$userEmail.jpg');
      return await ref.getDownloadURL();
    } catch (error) {
      print('Error getting profile image URL: $error');
      return 'URL_DE_LA_IMAGEN_POR_DEFECTO';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
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
      body: FutureBuilder<Map<String, dynamic>>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            String username = snapshot.data?['username'] ?? 'Nombre de Usuario';
            String email = snapshot.data?['email'] ?? 'correo@example.com';
            String profileImageUrl = snapshot.data?['profileImage'] ??
                'URL_DE_LA_IMAGEN_POR_DEFECTO';

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        profileImageUrl != 'URL_DE_LA_IMAGEN_POR_DEFECTO'
                            ? NetworkImage(profileImageUrl)
                            : AssetImage('assets/usuario-de-perfil.png')
                                as ImageProvider,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Usuario: $username',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Correo: $email',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool notificationsEnabled;
  final Function(bool) onNotificationToggle;

  const SettingsScreen({
    Key? key,
    required this.notificationsEnabled,
    required this.onNotificationToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white.withAlpha(200),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 10.0),
            Text(
              'Ajustes',
              style: TextStyle(
                fontSize: 27.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ... Other widgets

          // Switch to toggle notifications
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.notifications,
                color: Color(0xFF1F3DD0),
              ),
              Text(
                'Notificaciones:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 20.0),
              Switch(
                value: notificationsEnabled,
                onChanged: (newValue) {
                  onNotificationToggle(newValue);
                },
                activeColor: Color(0xFF1F3DD0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

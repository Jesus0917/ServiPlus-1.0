import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
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
            imagePath: services[index]['image'] ?? '',
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
          valNotify1: notificationsEnabled,
          valNotify2: false,
          valNotify3: false,
          onChanged1: _toggleNotifications,
          onChanged2: (value) {},
          onChanged3: (value) {},
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

  const ServiceCard({
    Key? key,
    required this.serviceName,
    required this.imagePath,
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
                builder: (context) => ListaTrabajadores(serviceName),
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

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key? key,
    required this.valNotify1,
    required this.valNotify2,
    required this.valNotify3,
    required this.onChanged1,
    required this.onChanged2,
    required this.onChanged3,
  }) : super(key: key);

  final bool valNotify1;
  final bool valNotify2;
  final bool valNotify3;
  final Function(bool) onChanged1;
  final Function(bool) onChanged2;
  final Function(bool) onChanged3;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool valNotify1 = true;
  bool valNotify2 = false;
  bool valNotify3 = false;

  void onChangeFunction1(bool newValue1) {
    setState(() {
      valNotify1 = newValue1;
    });
  }

  void onChangeFunction2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  void onChangeFunction3(bool newValue3) {
    setState(() {
      valNotify3 = newValue3;
    });
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
            'Configuracion',
            style: TextStyle(
              fontSize: 27.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 40,),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Color(0xFF1F3DD0),
                ),
                SizedBox(width: 10,),
                Text("Cuenta", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)
              ],
            ),
            Divider(height: 20,thickness: 1),
            SizedBox(height: 10),
            buildAccountOpion(context, "Cambiar Contraseña"),
            buildAccountOpion(context, "Configuracion de contenido"),
            buildAccountOpion(context, "Social"),
            buildAccountOpion(context, "Language"),
            buildAccountOpion(context, "Privacidad y Seguridad"),
            SizedBox(height: 40),
            Row(
              children: [
                Icon(Icons.volume_up_outlined, color: Color(0xFF1F3DD0)),
                SizedBox(width: 10),
                Text("Notificaciones", style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),)
              ],
            ),
            Divider(height: 20, thickness: 1),
            SizedBox(height: 10),
            buildNotificationOpntion("Tema Oscuro", valNotify1, onChangeFunction1),
            buildNotificationOpntion("Cuenta Activa", valNotify2, onChangeFunction2),
            buildNotificationOpntion("Oportunidad", valNotify3, onChangeFunction3),
            SizedBox(height: 50),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ), 
                onPressed: (){},
                child: Text("CERRAR SESION", style: TextStyle(
                  fontSize: 16, 
                  letterSpacing: 2.2, 
                  color: Colors.black
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding buildNotificationOpntion(String title, bool value, Function onChangeMethod) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600]
          )),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Color(0xFF1F3DD0),
              trackColor: Colors.grey,
              value: value,
              onChanged: (bool newValue){
                onChangeMethod(newValue);
              },
            ),
          )
        ],
      ),
    );
  }

  GestureDetector buildAccountOpion(BuildContext context, String title){
    return GestureDetector(
      onTap:(){
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Option 1"),
                Text("Option 2"),
              ],
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              },
               child: Text("Cerrar")
               )
            ],
          );
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey
            )),
            Icon(Icons.arrow_back_ios, color: Colors.grey)
          ],
        ),
      ) 
    );
  }
}
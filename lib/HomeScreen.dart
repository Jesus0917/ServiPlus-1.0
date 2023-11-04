import 'package:flutter/material.dart';
import 'WorkerProfileScreen.dart';
Color miColorPersonalizado = const Color(0xFF1F3DD0);
void main() {
  runApp(const MaterialApp(
    home: HomeScreen(), // Inicia la aplicación con la pantalla HomeScreen
    debugShowCheckedModeBanner: false, // Desactiva el banner de depuración
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() =>
      _HomeScreenState(); // Crea una instancia de _HomeScreenState
}

class _HomeScreenState extends State<HomeScreen> {
  // Define una lista de servicios con nombres e imágenes
  final List<Map<String, String>> services = [
    {'name': 'Plomero', 'image': 'assets/plomero.png'},
    {'name': 'Aseador', 'image': 'assets/limpiador.png'},
    {'name': 'Profesor', 'image': 'assets/profesor.png'},
    {'name': 'Electricista', 'image': 'assets/rayo.png'},
    {'name': 'Mecanico', 'image': 'assets/reparando.png'},
    {'name': 'Paseador', 'image': 'assets/caminando-con-perro.png'},
    {'name': 'Cocinero', 'image': 'assets/cocinero.png'},
    {'name': 'Lavanderia', 'image': 'assets/servicio-de-lavanderia.png'},
    // Puedes agregar más servicios aquí
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Center(
            child: Text(
              'Servicios',
              style: TextStyle(
                fontSize: 27.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: _buildCurrentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: miColorPersonalizado, // Cambia el color de los botones seleccionados
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            if (index == 0) {
              _navigateToHomeScreen();
            } else if (index == 1) {
              _navigateToAccountScreen(
                  context); // Pasamos el contexto a la pantalla de cuenta
            } else if (index == 2) {
              _navigateToSettingsScreen(context);
            }
          });
        },

        //iconos barra inferior
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  // Método para construir la pantalla actual
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
        child: AccountScreen(), // Mostrar la pantalla de cuenta
      );
    } else {
      return Container();
    }
  }

  // Método para navegar a la página de inicio (Home)
  void _navigateToHomeScreen() {
    // Implementar la navegación a la página de inicio (Home) si es necesario
  }

  // Método para mostrar la pantalla de cuenta como un diálogo
  void _navigateToAccountScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AccountDialog();
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

class ServiceCard extends StatelessWidget {
  final String serviceName;
  final String imagePath;

  const ServiceCard(
      {super.key, required this.serviceName, required this.imagePath});

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
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  height: 40,
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
    super.key,
    required this.name,
    required this.price,
    required this.imagePath,
  });

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
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Información de la cuenta',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Agrega más widgets para mostrar información de la cuenta
      ],
    );
  }
}

class AccountDialog extends StatelessWidget {
  const AccountDialog({super.key});

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
              'Información de la cuenta',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Agrega más widgets para mostrar información de la cuenta
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo de cuenta
              },
              child: const Text('Cerrar'),
            ),
          ],
        ),
      ),
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

class WorkerProfileScreen extends StatelessWidget {
  const WorkerProfileScreen({super.key, required this.serviceName});

  final String serviceName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Worker Profile'),
      ),
      body: Center(
        child: Text('This is the worker profile screen'),
      ),
    );
  }
}

class ListaTrabajadores extends StatelessWidget {
  final String serviceName;

  const ListaTrabajadores(this.serviceName, {super.key});

  final int _currentIndex = 0;

  void _navigateToSettingsScreen(BuildContext context) {
    // Navegar a la pantalla de Settings (falta implementar)
  }

  void _navigateToAccountScreen(BuildContext context) {
    // Navegar a la pantalla de Account (falta implementar)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'Personas Disponibles - $serviceName',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WorkerProfileScreen(
                            serviceName: 'Juan Pérez')));
              },
              child: SizedBox(
                width: 500, // Ancho personalizado
                child: WorkerContainer(
                  name: 'Juan Pérez',
                  price: '\$20000/hora',
                  imagePath: 'assets/worker1.jpg',
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Add the action you want to perform when this worker is tapped
              },
              child: SizedBox(
                width: 500, // Ancho personalizado
                child: WorkerContainer(
                  name: 'María López',
                  price: '\$18000/hora',
                  imagePath: 'assets/worker2.jpg',
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Add the action you want to perform when this worker is tapped
              },
              child: SizedBox(
                width: 500, // Ancho personalizado
                child: WorkerContainer(
                  name: 'Carlos Sánchez',
                  price: '\$25000/hora',
                  imagePath: 'assets/worker3.jpg',
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Add the action you want to perform when this worker is tapped
              },
              child: SizedBox(
                width: 500, // Ancho personalizado
                child: WorkerContainer(
                  name: 'Ana Martínez',
                  price: '\$22000/hora',
                  imagePath: 'assets/worker4.jpg',
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Add the action you want to perform when this worker is tapped
              },
              child: SizedBox(
                width: 500, // Ancho personalizado
                child: WorkerContainer(
                  name: 'Roberto Rodríguez',
                  price: '\$30000/hora',
                  imagePath: 'assets/worker5.jpg',
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Add the action you want to perform when this worker is tapped
              },
              child: SizedBox(
                width: 500, // Ancho personalizado
                child: WorkerContainer(
                  name: 'Sara Gómez',
                  price: '\$18000/hora',
                  imagePath: 'assets/worker6.jpg',
                ),
              ),
            ),
            // Add more contenedores aquí
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          if (index == 0) {
            Navigator.pop(context);
          } else if (index == 1) {
            // Implement navigation to the account screen here
          } else if (index == 2) {
            // Implement navigation to the settings screen here
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

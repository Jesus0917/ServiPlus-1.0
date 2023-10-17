import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> services = [
    {'name': 'Plomero', 'image': 'assets/plomero.png'},
    {'name': 'Aseador', 'image': 'assets/limpiador.png'},
    {'name': 'Profesor', 'image': 'assets/profesor.png'},
    {'name': 'Electricista', 'image': 'assets/rayo.png'},
    {'name': 'Mecanico', 'image': 'assets/reparando.png'},
    {'name': 'Paseador', 'image': 'assets/caminando-con-perro.png'},
    {'name': 'Cocinero', 'image': 'assets/cocinero.png'},
    {'name': 'Lavanderia', 'image': 'assets/servicio-de-lavanderia.png'},
    // Agrega otros servicios aquí
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
            child: Text(
              'Servicios',
              style: TextStyle(
                fontSize: 27.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(200.0),
              bottomRight: Radius.circular(200.0),
            ),
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
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

class ServiceCard extends StatelessWidget {
  final String serviceName;
  final String imagePath;

  ServiceCard({required this.serviceName, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0, // Establece la elevación en 0 para quitar la sombra
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
            height: 120, // Modifica el valor de height según tus preferencias
            width: double.infinity,
            color: Colors.white, // Establece el fondo en blanco
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  height: 40, // Modifica el valor de height según tus preferencias
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    serviceName,
                    style: TextStyle(
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
class ListaTrabajadores extends StatelessWidget {
  final String serviceName;

  ListaTrabajadores(this.serviceName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        backgroundColor: Colors.transparent,
        elevation: 0, // Establece la elevación en 0 para quitar la sombra
        title: Center(
          child: Text(
            'Personas Disponibles - $serviceName',
            style: TextStyle(
              fontSize: 27.0,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Color del texto (negro)
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white, // Establece el fondo blanco
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (int index) {
          if (index == 0) {
            // Navegar de regreso a HomeScreen
            Navigator.pop(context);
          } else {
            // Manejar otras opciones de navegación si es necesario
          }
        },
        items: [
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




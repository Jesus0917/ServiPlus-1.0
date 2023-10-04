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
  // Lista de servicios con sus nombres y rutas de imágenes
  final List<Map<String, String>> services = [
    {'name': 'Plomero', 'image': 'assets/plomero.png'},
    {'name': 'Limpiador', 'image': 'assets/limpiador.png'},
    {'name': 'Profesor', 'image': 'assets/profesor.png'},
    {'name': 'Electricista', 'image': 'assets/rayo.png'},
    {'name': 'Mecanico', 'image': 'assets/reparando.png'},
    {'name': 'Paseador', 'image': 'assets/caminando-con-perro.png'},
    {'name': 'Cocinero', 'image': 'assets/cocinero.png'},
    {'name': 'Lavanderia', 'image': 'assets/servicio-de-lavanderia.png'},
  ];

  int _currentIndex = 0; // Índice de la opción seleccionada en la barra de navegación

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
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
        currentIndex: _currentIndex, // Índice de la opción seleccionada
        onTap: (int index) {
          setState(() {
            _currentIndex = index; // Actualiza el índice cuando se toca una opción
            if (_currentIndex == 0) {
              // aquí colocar a dónde se quiere llevar, es decir, al home
              
            } else if (_currentIndex == 1) {
              // aquí colocar la página de configuración
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
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
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(200.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200.0), // Borde circular
        child: Container(
          height: 20, // Ajustar la altura del contenedor
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 224, 224, 224),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centrar el contenido verticalmente
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.contain, // Ajustar la imagen al contenedor
                height: 90, // Altura deseada para la imagen
              ),
              SizedBox(height: 15.0), // Espacio entre la imagen y el texto
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  serviceName,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
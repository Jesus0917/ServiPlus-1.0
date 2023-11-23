import 'dart:ui';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Configuración para Android
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('assets/logo.png'); // Reemplaza 'app_icon' con el nombre de tu icono de la aplicación

  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class WorkerProfileScreen extends StatelessWidget {
  const WorkerProfileScreen({
    Key? key,
    required this.serviceName,
    this.imagePath = '',
    this.price = '',
  }) : super(key: key);

  final String serviceName;
  final String imagePath;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Text(
            'Trabajador',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(imagePath.isEmpty
                    ? 'assets/usuario-de-perfil.png' // Imagen por defecto
                    : imagePath),
              ),
              SizedBox(height: 20),
              Text(
                'Nombre: $serviceName',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Precio: $price', // Muestra el precio
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  launch("tel://<+573154746748>"); // Reemplaza <Número de teléfono> con el número que deseas llamar

                },
                icon: Icon(Icons.phone),
                label: Text('Llamar'),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      await _mostrarDialogAceptar(context);
                      _enviarNotificacion();
                    },
                    icon: Icon(Icons.check),
                    label: Text('Aceptar Trabajador'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context); // Regresar al home
                    },
                    icon: Icon(Icons.arrow_back),
                    label: Text('Regresar'),
                  ),
                ],
              ),
              // Agrega más información del trabajador según sea necesario
            ],
          ),
        ),
      ),
    );
  }
}

// Función para mostrar un diálogo
  Future<void> _mostrarDialogAceptar(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Aceptar Trabajador'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Estás seguro de que quieres aceptar a este trabajador?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
          ],
        );
      },
    );
  }
  // Inicializa FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Función para enviar notificación
Future<void> _enviarNotificacion() async {
  // **Importante:** Cambia 'trabajos_aceptados' y 'Trabajos Aceptados' por valores únicos para tu aplicación
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('trabajos_aceptados', 'Trabajos Aceptados',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true, // Añade un sonido a la notificación
        showWhen: false,
      );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // Identificador único de la notificación
    'Trabajador Aceptado', // Título de la notificación
    'Has aceptado a un trabajador', // Contenido de la notificación
    platformChannelSpecifics,
    payload: 'Trabajador aceptado', // Datos adicionales que se pueden pasar a la notificación
  );
}

class ListaTrabajadores extends StatelessWidget {
  final List<Map<String, String>> workers;
  final String serviceName;

  const ListaTrabajadores(this.workers, {super.key, required this.serviceName});

  void _navigateToSettingsScreen(BuildContext context) {}

  void _navigateToAccountScreen(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'Personas Disponibles',
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
              child: const SizedBox(
                width: 500, // Ancho personalizado
                child: WorkerContainer(
                  name: 'Juan Pérez',
                  price: '\$20000/hora', 
                  imagePath: '',
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WorkerProfileScreen(
                            serviceName: 'María López')));
              },
              child: const SizedBox(
                width: 500, // Ancho personalizado
                child: WorkerContainer(
                  name: 'María López',
                  price: '\$18000/hora',
                  imagePath: '',
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WorkerProfileScreen(
                            serviceName: 'Carlos Sánchez')));
              },
              child: const SizedBox(
                width: 500, // Ancho personalizado
                child: WorkerContainer(
                  name: 'Carlos Sánchez',
                  price: '\$25000/hora',
                  imagePath: '',
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WorkerProfileScreen(
                            serviceName: 'Ana Martínez')));
              },
              child: const SizedBox(
                width: 500, // Ancho personalizado
                child: WorkerContainer(
                  name: 'Ana Martínez',
                  price: '\$22000/hora',
                  imagePath: '',
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WorkerProfileScreen(
                            serviceName: 'Roberto Rodríguez')));
              },
              child: const SizedBox(
                width: 500, // Ancho personalizado
                child: WorkerContainer(
                  name: 'Roberto Rodríguez',
                  price: '\$30000/hora',
                  imagePath: '',
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WorkerProfileScreen(
                            serviceName: 'Sara Gómez')));
              },
              child: const SizedBox(
                width: 500, // Ancho personalizado
                child: WorkerContainer(
                  name: 'Sara Gómez',
                  price: '\$18000/hora',
                  imagePath: '',
                ),
              ),
            ),
            // Add more contenedores aquí
          ],
        ),
      ),
    );
  }
}
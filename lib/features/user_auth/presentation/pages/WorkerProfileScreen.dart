import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/user_auth/presentation/pages/home_page.dart';
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
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id', // Cambia esto según tus necesidades
      'your channel name', // Cambia esto según tus necesidades
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Trabajador Aceptado',
      'Has aceptado a un trabajador',
      platformChannelSpecifics,
      payload: 'Trabajador aceptado',
    );
  }

class ListaTrabajadores extends StatelessWidget {
  final List<Map<String, String>> workers;

  const ListaTrabajadores(this.workers, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ... otras configuraciones de la barra de aplicaciones
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int index = 0; index < workers.length; index++)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkerProfileScreen(
                        serviceName: workers[index]['name'] ?? '',
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  width: 500,
                  child: WorkerContainer(
                    name: workers[index]['name'] ?? '',
                    price: workers[index]['price'] ?? '',
                    imagePath: workers[index]['imagePath'] ?? '',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
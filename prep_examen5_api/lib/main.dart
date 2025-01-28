import 'dart:convert'; // Para convertir la respuesta JSON en objetos
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Paquete para hacer solicitudes HTTP

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // Lista de usuarios que se llenará con la respuesta de la API
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Función para obtener los datos de la API
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      // Si la respuesta es exitosa, parseamos el JSON
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        // Convertimos cada elemento JSON en un objeto User
        users = data.map((json) => User.fromJson(json)).toList();
      });
    } else {
      // Si la respuesta no es exitosa, mostramos un error
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API Data Example")),
      body: users.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Mostrar cargando si no hay datos
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                );
              },
            ),
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  // Método para crear un User desde un JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
import 'package:flutter/material.dart';

void main() {
  //aqui hay menu lateral DRAWER, menu flotante(aparece abajo a la derecha), aplicacion con pestañas
  runApp(const MaterialApp(home: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  
  @override
  State<StatefulWidget> createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Ejemplo tabBar")),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Inicio"),
              Tab(icon: Icon(Icons.star), text: "Favoritos"),
              Tab(icon: Icon(Icons.settings), text: "Configuración")
            ],
          ),
        ),
        
        floatingActionButton: PopupMenuButton<String>(
          icon: const Icon(Icons.accessible_forward_rounded),
          onSelected: (value) {
            debugPrint("Seleccionaste: $value");
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: "Inicio",
              child: Text("Inicio"),
            ),
            const PopupMenuItem(
              value: "Favoritos",
              child: Text("Favoritos"),
            ),
            const PopupMenuItem(
              value: "Configuración",
              child: Text("Configuración"),
            ),
          ],
        ),
        
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bienvenido",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "usuario@ejemplo.com",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Inicio"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Configuración"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Cerrar sesión"),
              onTap: () {
                Navigator.pop(context);
              })],
          ),
        ),
        
        body: const TabBarView(
          children: [
            Center(child: Text("Pantalla de Inicio")),
            Center(child: Text("Pantalla de Favoritos")),
            Center(child: Text("Pantalla de Configuración"))
          ],)
      ),
    );
  }
}

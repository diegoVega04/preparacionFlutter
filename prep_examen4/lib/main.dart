import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //añadir tambien en las dependencias

void main() {
  //tooltip, gridview, intl, theme
  runApp(const AAA()); //clase para probar el cambio entre modo claro y oscuro
  //runApp(MaterialApp(
    //themeMode: ThemeMode.system, //para que pille automaticamente el del sistema (claro u oscuro)
    //home: MainApp()));
}


class AAA extends StatefulWidget{
  const AAA({super.key});

  @override
  State<StatefulWidget> createState() => _AAA();
}

class _AAA extends State<AAA> {
  bool _s = false;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
            primarySwatch: Colors.green, // Color principal de la aplicación
            brightness: _s? Brightness.dark :Brightness.light, // Tema claro u oscuro
            textTheme: const TextTheme( // Estilo para los textos
              bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
      home: Scaffold(
        body: Switch(
          activeColor: Colors.grey,
          value: _s, 
          onChanged: (value) => setState(() {
            _s = value;
          })),
      ),
    );
  }

}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final List<String> items = List.generate(20, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.sizeOf(context).width;

    // Determinar el número de columnas en el Grid según el tamaño de la pantalla
    int crossAxisCount;
    if (width < 600) {
      crossAxisCount = 2; // Para pantallas pequeñas
    } else if (width < 900) {
      crossAxisCount = 4; // Para pantallas medianas
    } else {
      crossAxisCount = 6; // Para pantallas grandes
    }

    return Scaffold(
      appBar: AppBar(title: const Text('GridView con BreakPoints')),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Tooltip(
            message: 'Este es el ${items[index]}', // Tooltip que aparece al pasar el mouse
            child: GestureDetector(
              onTap: () {
                // Acción al hacer clic en un item
                final now = DateTime.now();
                final formattedDate = DateFormat.yMd().format(now); // Formato de fecha con intl
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Fecha Actual'),
                    content: Text('La fecha actual es: $formattedDate'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cerrar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                color: Colors.blueAccent,
                alignment: Alignment.center,
                child: Text(
                  items[index],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  List<int> devolverPares(List<int> a) => a.where((n) => n % 2 == 0).toList();
  final List<int> ejemplo = [1,2,3,4,5,6,7,8,9,10];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ListView.builder(
            itemCount: devolverPares(ejemplo).length,
            itemBuilder: (context, index) {
              return ListTile(title: Text("numero ${devolverPares(ejemplo)[index]}"));
            }
          )
        ),
      ),
    );
  }
}

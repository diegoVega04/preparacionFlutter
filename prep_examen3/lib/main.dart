import 'package:flutter/material.dart';

void main() {
  //listView.builder contiene por asi decirlo un scrollView ya de por si
  //el .separated se hace igual pero añadiendo esto 
  //separatorBuilder: (context, index) {
      //return const Divider(
        //thickness: 2,
        //color: Colors.grey,
      //);
  //Si es para meter distintos widgets y tal usar el ScrollView con un colum como child y ahi metes todo
  runApp(MaterialApp(home: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  
  @override
  State<StatefulWidget> createState() => _MainApp();

}

class _MainApp extends State<MainApp> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("ScrollView"))),
      body: Center(child: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.star),
              title: Text('Item $index'),
              subtitle: Text('Subtítulo del item $index'),
            );
          },
        )
      ),
    );  
  }

}

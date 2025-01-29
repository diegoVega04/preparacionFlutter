import 'package:ejercicios_repaso/viewModel/contadorVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContadorScreen extends StatelessWidget {
  const ContadorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final contadorVM = Provider.of<ContadorViewModel> (context);

    return Scaffold(
      appBar: AppBar(title: Text("Contador prueba M-VM-V")),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Contador: ${contadorVM.counter}"),
        SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            onPressed: contadorVM.decrement,
            child: Text("-")),
          SizedBox(width: 30),
          ElevatedButton(
            onPressed: contadorVM.increment,
            child: Text("+"))
        ])
      ])),
    );
  }
}
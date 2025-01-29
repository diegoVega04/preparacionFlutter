import 'package:ejercicios_repaso/model/ContadorM.dart';
import 'package:ejercicios_repaso/view/contadorV.dart';
import 'package:ejercicios_repaso/viewModel/contadorVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ContadorViewModel(ContadorModel()),
      child: MainApp()
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContadorScreen()
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; //importar lo de sharedPreferences tambien en las dependencias

void main() {
  //aqui hay dropDownButton, switch, checkbox, image y mediaQuery.sizeOf
  //tambien lo de sharedPreferences --> solo funciona en android pero por si lo pide
  runApp (const MaterialApp(home: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  
  @override
  State<StatefulWidget> createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  String? _opcionDDB;
  bool _switchIsOn = false;
  bool _checkIsOn = false;
  
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  //metodos para las sharedPreferences
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _switchIsOn = prefs.getBool('switchState') ?? false; //pone por defecto false
      _checkIsOn = prefs.getBool('checkboxState') ?? false;
    });
  }

  Future<void> _saveSwitchState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('switchState', value);
  }

  Future<void> _saveCheckboxState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('checkboxState', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Prueba examen")),
      ),
      body: SafeArea(child:Center(child: 
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          DropdownButton(
          value: _opcionDDB,
          hint: const Text("Selecciona una opcion"),
          items: const [
            DropdownMenuItem(value: "Opcion 1", child: Text("Opcion 1")),
            DropdownMenuItem(value: "Opcion 2", child: Text("Opcion 2")),
            DropdownMenuItem(value: "Opcion 3", child: Text("Opcion 3")),
          ], 
          onChanged: (value) => setState(() {_opcionDDB = value!;}),
        ),
        if (_opcionDDB != null)
          Container(margin: const EdgeInsets.all(20), child: Text("Seleccionaste: $_opcionDDB")),
        Switch(
          value: _switchIsOn,
          onChanged: (bool newValue) {
            setState(() {
              _switchIsOn = newValue;
              _saveSwitchState(newValue);
            });
          },
          activeColor: Colors.green,
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.red,
        )
        ],),
        const SizedBox(height: 40, width: 40),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          _switchIsOn?
          const Text("Switch encendido")
          : const Text("Switch apagado"),
          Checkbox(
            value: _checkIsOn, 
            onChanged: (value) => setState(() {
              _checkIsOn = value!;
              _saveCheckboxState(value);
            })),

          _checkIsOn?
          const Text("Check puesto")
          : const Text ("Check no puesto"),


        ]),
        const SizedBox(height: 40, width: 40),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width/3, //esto me pilla la pantalla de la app no del portatil
            height: MediaQuery.sizeOf(context).height/3, //supongo que en movil te pilla la pantalla pq todo es a pantalla completa
            child: Image.network("https://fotos.quecochemecompro.com/opel-corsa/opel-corsa-dinamismo-carretera.jpg?size=750x400",
              fit: BoxFit.contain)), //esto es para que se ajuste al tamaño del contenedor y se vea entera
          
        ])
        ])),
    ));
  }
}

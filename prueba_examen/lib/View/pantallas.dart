import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:prueba_examen/ViewModel/language_provider.dart';
import 'package:prueba_examen/ViewModel/theme_provider.dart';


class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations local = AppLocalizations.of(context)!;
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(local.lb_darkTheme),
              Switch(
                value: themeProvider.theme.brightness == Brightness.dark,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
            ],
          )),
          Card(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(local.lb_language),
              DropdownButton<String>(
                value: languageProvider.locale.languageCode == 'es' ? "Español" : "English",
                items: [
                  DropdownMenuItem(value: "Español", child: Text("Español")),
                  DropdownMenuItem(value: "English", child: Text("English")),
                ],
                onChanged: (value) {
                  languageProvider.toggleLanguage();
                },
              ),
            ],
          )),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(local.lb_textSize),
                Slider(
                  min: 10.0,
                  max: 24.0,
                  divisions: 14,
                  value: themeProvider.theme.textTheme.bodyLarge?.fontSize ?? 16.0, 
                  onChanged: (value) {
                    themeProvider.changeText(value);
                  })
              ],
            ),
          )
        ],
    );
  }
}

class Converter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Converter();
}

class _Converter extends State<Converter> {
  double? cantidadInicial;
  double? resultado;
  String medidaInicial = "Km";
  String medidaResultado = "Km";
  var _error;
  final TextEditingController _con = TextEditingController();

  static const conversionRates = {
    'Km' : {'Km':1.0, 'm':1000.0, 'Mll': 0.621371},
    'm': {'Km': 0.001, 'm':1, 'Mll': 0.000621371},
    'Mll': {'Km':1.60934, 'm':1609.34, 'Mll': 1}
  };

  @override
  Widget build(BuildContext context) {
    final AppLocalizations local = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onTap: () => setState(() {
            _error = null;
          }),
          controller: _con,
          decoration: InputDecoration(
            labelText: local.lb_inputValue, 
            errorText: _error),
        ),
        SizedBox(height: 10),
        DropdownButton(
          value: medidaInicial,
          items: [
            DropdownMenuItem(value: "Km",child: Text("Km")),
            DropdownMenuItem(value: "Mll",child: Text("Mll")),
            DropdownMenuItem(value: "m",child: Text("m")),
          ], 
          onChanged: (value) => setState(() {
            medidaInicial = value!;
          })),
        SizedBox(height: 1.5),
        Icon(Icons.arrow_downward),
        SizedBox(height: 1.5),
        DropdownButton(
          value: medidaResultado,
          items: [
            DropdownMenuItem(value: "Km",child: Text("Km")),
            DropdownMenuItem(value: "Mll",child: Text("Mll")),
            DropdownMenuItem(value: "m",child: Text("m")),
          ], 
          onChanged: (value) => setState(() {
            medidaResultado = value!;
          })),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => setState(() {
            try {
              cantidadInicial = double.tryParse(_con.text);
              resultado = (cantidadInicial! * (conversionRates[medidaInicial])![medidaResultado]!);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(local.message),
                ),
              );
            } catch (exception) {
              _error = "Inserte un valor valido";
            }
          }), 
          child: Text(local.txt_button)),
        SizedBox(height: 10),
        Text("${local.txt_result} $resultado")
      ],
    );
  }

}



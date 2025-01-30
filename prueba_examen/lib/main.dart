import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:prueba_examen/View/pantallas.dart';
import 'package:prueba_examen/ViewModel/language_provider.dart';
import 'package:prueba_examen/ViewModel/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: A(),
    ));
}

class A extends StatelessWidget {
  const A({super.key});
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return MaterialApp(
      theme: themeProvider.theme, 
      title: 'Flutter Demo',
      locale: languageProvider.locale,
      supportedLocales: const [
        Locale('en'), // Inglés
        Locale('es'), // Español
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Main()
    );
  }
}

class Main extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Main();
}

class _Main extends State<Main> {
  
  List<Widget> pantallas = [
    Converter(),
    Settings(),
    Settings()
  ];

  var titulo = "Convertirdor";
  
  int n = 0;
  
  @override
  Widget build(BuildContext context) {
    final AppLocalizations local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Center(child: Text(titulo))),
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
                    "Menu",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.compare_arrows),
              title: Text(local.titleConverter),
              onTap: () {
                setState(() {
                  n = 0;
                  titulo = local.titleConverter;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: Text(local.tittleTransactions),
              onTap: () {
                setState(() {
                  n = 1;
                  titulo = local.tittleTransactions;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(local.titleSetting),
              onTap: () {
                setState(() {
                  n = 2;
                  titulo = local.titleSetting;
                  Navigator.pop(context);
                });
              })],
          )
      ),
      body: Container(padding: EdgeInsets.all(20),child: pantallas[n]),
    );
  }

}
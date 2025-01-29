import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'language_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
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
      home: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController _conNom = TextEditingController();
  final TextEditingController _conTfno = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations local = AppLocalizations.of(context)!;
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(local.title),
        actions: [
          Row(
            children: [
              const Text("ES"),
              Switch(
                value: languageProvider.locale.languageCode == 'en',
                onChanged: (value) {
                  languageProvider.toggleLanguage();
                },
              ),
              const Text("EN"),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _conNom,
              decoration: InputDecoration(
                labelText: local.name,
                hintText: local.enter_name,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _conTfno,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: local.phone,
                hintText: local.enter_phone,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      local.message(_conNom.text, _conTfno.text),
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: Text(local.send),
            ),
          ],
        ),
      ),
    );
  }
}
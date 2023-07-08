import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hangman',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: context.watch<ThemeNotifier>().themeMode,
      home: const MyHomePage(),
    );
  }
}

final lightColorScheme = ColorScheme.light(
  primary: Colors.blueGrey[900]!,
  primaryVariant: Colors.blueGrey[800]!,
  secondary: Colors.teal,
  secondaryVariant: Colors.teal[700]!,
);


final darkColorScheme = ColorScheme.fromSwatch(
  primarySwatch: Colors.deepPurple,
  brightness: Brightness.dark,
).copyWith(
  secondary: Colors.deepPurpleAccent,
);

final lightTheme = ThemeData(
  colorScheme: lightColorScheme,
);

final darkTheme = ThemeData(
  colorScheme: darkColorScheme,
);

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hangman'),
        actions: [
          IconButton(
            onPressed: () {
              final currentThemeMode = themeNotifier.themeMode;
              final newThemeMode = currentThemeMode == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
              themeNotifier.setThemeMode(newThemeMode);
            },
            icon: Icon(
              themeNotifier.themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
          ),
        ],
      ),
      body: Center(
        child: const Text('Welcome to Hangman!'),
      ),
    );
  }
}

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}

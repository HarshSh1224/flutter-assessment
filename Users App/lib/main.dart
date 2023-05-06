import 'package:flutter/material.dart';
import 'package:usersapp/screens/home_screen.dart';
import 'package:usersapp/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var brightness = Brightness.light;

  void _toggleTheme() {
    setState(() {
      brightness =
          brightness == Brightness.light ? Brightness.dark : Brightness.light;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: brightness,
        useMaterial3: true,
      ),
      home: LoginScreen(_toggleTheme),
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(_toggleTheme),
      },
    );
  }
}

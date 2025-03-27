import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'current_locations.dart';
import 'qr_scanner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crescendo Safe Routes',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SafeRoutesScreen(), // Replace with your Safe Routes Screen
    );
  }
}

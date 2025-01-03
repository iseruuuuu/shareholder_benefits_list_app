import 'package:flutter/material.dart';
import 'features/ui/shareholder_benefits_list_screen.dart';

typedef VoidCallback = void Function();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ShareholderBenefitsListScreen(),
    );
  }
}

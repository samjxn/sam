import 'package:flutter/material.dart';
import 'package:sam/src/ui/screens/home_screen.dart';

class PortfolioApplication extends StatelessWidget {
  const PortfolioApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sam Jackson',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

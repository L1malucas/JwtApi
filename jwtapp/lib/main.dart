import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jwtapp/Views/Pages/menu_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MenuPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://camo.githubusercontent.com/753feb432db3a5ad9eb538e819191aed7402d20ff533ed480a616c4a245ec777/68747470733a2f2f7265666572627275762e636f6d2f77702d636f6e74656e742f75706c6f6164732f323032322f30352f6a77742d646f746e6574636f72652d62616e6e65722e706e67',
    );
  }
}

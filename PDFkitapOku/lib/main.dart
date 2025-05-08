import 'package:deneme/screns/SplashScreen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const Uygulamam());
}

class Uygulamam extends StatelessWidget {
  const Uygulamam({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uygulamam',
      home: SplashScreen(),
    );
  }
}

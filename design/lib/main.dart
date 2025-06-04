import 'package:flutter/material.dart';

import 'package:design/screens/basic_design.dart';
import 'package:design/screens/medium_design.dart';
import 'package:design/screens/hard_design.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'hard_design',
      routes: {
        'basic_design': (_) => BasicDesignScreen(),
        'medium_design': (_) => mediumDesignScreen(),
        'hard_design': (_) => hardDesignScreen(),
      },
    );
  }
}

class _TempHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('data'),
        const Text('data'),
      ],
    );
  }
}

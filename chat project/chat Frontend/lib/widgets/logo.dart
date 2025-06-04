import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String title;

  const Logo({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          children: const [
            Image(
              image: AssetImage('assets/logo-beplic.png'),
              alignment: Alignment.bottomCenter,
            ),
            // const SizedBox(height: 20),
            // Text(
            //   title,
            //   style: const TextStyle(fontSize: 30),
            // ),
          ],
        ),
      ),
    );
  }
}

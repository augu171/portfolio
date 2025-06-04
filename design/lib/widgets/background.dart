// ignore_for_file: camel_case_types, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});
  final boxDecoration = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.2, 0.8],
      colors: [
        Color(0xff2E305F),
        Color(0xff202333),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Grandiante morado
        Container(decoration: boxDecoration),
        //Caja rosada
        Positioned(top: -100, left: -30, child: _pinkBox()),
      ],
    );
  }
}

class _pinkBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 5,
      child: Container(
        width: 360,
        height: 360,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(235, 98, 188, 1),
              Color.fromRGBO(251, 142, 172, 1),
            ],
          ),
          borderRadius: BorderRadius.circular(80),
        ),
      ),
    );
  }
}

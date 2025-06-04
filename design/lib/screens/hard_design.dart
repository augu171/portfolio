// ignore_for_file: camel_case_types
import 'package:design/widgets/card_table.dart';
import 'package:flutter/material.dart';

import 'package:design/widgets/background.dart';
import 'package:design/widgets/custom_bottom_navigation.dart';
import 'package:design/widgets/page_title.dart';

class hardDesignScreen extends StatelessWidget {
  const hardDesignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          _HomeBody(),
        ],
      ),
      bottomNavigationBar: CustomNavigation(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const PageTitle(),
          CardTable(),
        ],
      ),
    );
  }
}

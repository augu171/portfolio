import 'package:flutter/material.dart';

import '../themes/app-themes.dart';

class CustomCardType1 extends StatelessWidget {
  const CustomCardType1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        const ListTile(
          leading: Icon(Icons.health_and_safety, color: AppTheme.primary),
          title: Text('Titulo'),
          subtitle: Text(
              'Nostrud consequat in officia minim qui nostrud voluptate cillum incididunt magna esse eu dolore. Sint magna ullamco excepteur veniam tempor. '),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('OK'),
              )
            ],
          ),
        )
      ],
    ));
  }
}

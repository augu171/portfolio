import 'package:flutter/material.dart';

class CardTable extends StatelessWidget {
  const CardTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: const [
        TableRow(
          children: [
            _SingleCard(
              color: Colors.blue,
              icon: Icons.border_all,
              text: 'General',
            ),
            _SingleCard(
              color: Colors.purple,
              icon: Icons.car_rental,
              text: 'Transports',
            ),
          ],
        ),
        TableRow(
          children: [
            _SingleCard(
              color: Colors.pink,
              icon: Icons.shopping_bag,
              text: 'Shopping',
            ),
            _SingleCard(
              color: Colors.orange,
              icon: Icons.pause_presentation,
              text: 'Bill',
            ),
          ],
        ),
        TableRow(
          children: [
            _SingleCard(
              color: Colors.blue,
              icon: Icons.play_circle_outline,
              text: 'Media',
            ),
            _SingleCard(
              color: Colors.green,
              icon: Icons.balance_outlined,
              text: 'algo mas',
            ),
          ],
        )
      ],
    );
  }
}

class _SingleCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _SingleCard({
    required this.icon,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      height: 180,
      decoration: BoxDecoration(
        color: Color.fromRGBO(62, 66, 107, 0.7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              icon,
              size: 35,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            text,
            style: TextStyle(color: Colors.blue, fontSize: 18),
          )
        ],
      ),
    );
  }
}

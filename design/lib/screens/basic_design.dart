import 'package:flutter/material.dart';

class BasicDesignScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Image(image: AssetImage('assets/paisaje.jpg')),
          Title(),
          buttonSection(),
          bodyText()
        ],
      ),
    );
  }
}

class bodyText extends StatelessWidget {
  const bodyText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: const Text(
        textAlign: TextAlign.justify,
        'Irure fugiat in magna sunt ullamco ullamco mollit esse incididunt ex ullamco officia sit. Consectetur id nulla do quis dolore reprehenderit reprehenderit exercitation do tempor sit. Consectetur est dolore laborum ullamco anim ad incididunt velit excepteur sunt laboris. Amet qui veniam laborum minim commodo in non. Occaecat est nisi reprehenderit veniam. Ipsum est ea nostrud cillum officia reprehenderit commodo esse veniam in. Sunt qui aliqua laboris laboris magna ad id aliqua aliquip officia sunt est.',
      ),
    );
  }
}

class buttonSection extends StatelessWidget {
  const buttonSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 75, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          buttonAndText(icon: Icons.call, text: 'CALL'),
          buttonAndText(icon: Icons.send_rounded, text: 'ROUTE'),
          buttonAndText(icon: Icons.share, text: 'SHARE'),
        ],
      ),
    );
  }
}

class buttonAndText extends StatelessWidget {
  final IconData icon;
  final String text;

  const buttonAndText({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.blue,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.blue),
        )
      ],
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Oeschinen Lake Campground',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                'Kandersteg, Switzerland',
                style: TextStyle(color: Colors.grey[350]),
              ),
            ],
          ),
          Expanded(child: Container()),
          Row(
            children: const [
              Icon(
                Icons.star,
                color: Colors.red,
              ),
              Text('41'),
            ],
          )
        ],
      ),
    );
  }
}

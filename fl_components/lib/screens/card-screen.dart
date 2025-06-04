import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Card Widget'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: const [
            CustomCardType1(),
            SizedBox(height: 20),
            CustomCardType2(
              imageUrl:
                  'https://encolombia.com/wp-content/uploads/2021/12/Que-es-paisaje.jpg',
              name: 'Paisaje 1',
            ),
            SizedBox(height: 20),
            CustomCardType2(
              imageUrl:
                  'https://images.pexels.com/photos/1619317/pexels-photo-1619317.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
            ),
            SizedBox(height: 20),
            CustomCardType2(
              imageUrl:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgOXTb1L9MyK-NGuJyuOV9O8TUTxhYK82Cuh1EAW_16ZukvP1LlPKMvhvkVz8MZ4pCXug&usqp=CAU',
              name: 'Paisaje 3',
            ),
            SizedBox(height: 20),
            CustomCardType2(
              imageUrl:
                  'https://cdn.pixabay.com/photo/2017/05/09/03/46/alberta-2297204__340.jpg',
            ),
            SizedBox(height: 50),
          ],
        ));
  }
}

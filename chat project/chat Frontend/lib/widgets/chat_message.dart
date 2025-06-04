import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String uid;
  final AnimationController animationController;

  const ChatMessage(
      {super.key,
      required this.text,
      required this.uid,
      required this.animationController});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: uid == authService.user!.uid ? _myMessage() : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 8, left: 50, right: 7),
        decoration: BoxDecoration(
          color: const Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: text.contains('.gif') ||
                text.contains('.jpg') ||
                text.contains('.heic') ||
                text.contains('.png')
            ? Image(
                image: NetworkImage(text),
              )
            : Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 8, right: 50, left: 7),
        decoration: BoxDecoration(
          color: const Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: text.contains('.gif') ||
                text.contains('.jpg') ||
                text.contains('.png')
            ? Image(
                image: NetworkImage(text),
              )
            : Text(
                text,
                style: const TextStyle(color: Colors.black87, fontSize: 16),
              ),
      ),
    );
  }
}

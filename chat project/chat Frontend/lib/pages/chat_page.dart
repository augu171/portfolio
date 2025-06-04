import 'dart:io';

import 'package:chat/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/auth_service.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/socket_service.dart';

import 'package:chat/models/messages_response.dart';
import 'package:chat/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  late ChatService chatService;
  SocketService? socketService;
  late AuthService authService;

  final List<ChatMessage> _messages = [];

  bool _isWritting = false;

  @override
  void initState() {
    super.initState();

    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService!.socket!.on('personal-msg', _listenMessage);

    _loadHistoryRecord(chatService.userTo!.uid);
  }

  void _loadHistoryRecord(String? userId) async {
    List<Last30> chat = await chatService.getChat(userId!);
    final history = chat.map(
      (m) => ChatMessage(
        text: m.msg,
        uid: m.from,
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 0))
          ..forward(),
      ),
    );
    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _listenMessage(dynamic payload) {
    ChatMessage message = ChatMessage(
      text: payload['msg'],
      uid: payload['from'],
      animationController: AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final userTo = chatService.userTo;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 35,
        backgroundColor: const Color.fromRGBO(226, 174, 47, 1),
        title: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 74, 125, 219),
              maxRadius: 18,
              child: Text(
                userTo!.name.substring(0, 2),
                style: const TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 6, 22, 27)),
              ),
            ),
            const SizedBox(width: 5),
            Text(
              userTo.name,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
              ),
            ),
            const Divider(height: 5),
            Container(
              color: Colors.white,
              height: 50,
              child: _inputChat(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () async {
                final picker = ImagePicker();
                final XFile? pickedFile = await picker.pickImage(
                    source: ImageSource.camera, imageQuality: 100);

                if (pickedFile == null) {
                  return;
                }
                _handleSubmit(await chatService.uploadImage(pickedFile.path));
              },
              icon: const Icon(Icons.camera_alt_outlined,
                  size: 30, color: Colors.grey),
            ),
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String text) {
                  setState(() {
                    if (text.trim().isNotEmpty) {
                      _isWritting = true;
                    } else {
                      _isWritting = false;
                    }
                  });
                },
                decoration:
                    const InputDecoration.collapsed(hintText: 'Send Message'),
                focusNode: _focusNode,
              ),
            ),
            IconButton(
              onPressed: () async {
                final picker = ImagePicker();
                final XFile? pickedFile = await picker.pickImage(
                    source: ImageSource.gallery, imageQuality: 100);

                if (pickedFile == null) {
                  return;
                }
                _handleSubmit(await chatService.uploadImage(pickedFile.path));
              },
              icon: const Icon(Icons.image, size: 35, color: Colors.grey),
            ),
            Container(
              margin: const EdgeInsets.only(right: 4.0),
              child: Platform.isIOS
                  ? (CupertinoButton(
                      child: const Text('Send'), onPressed: () {}))
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue[300]),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: const Icon(
                            Icons.send,
                          ),
                          onPressed: _isWritting
                              ? () {
                                  _handleSubmit(
                                    _textController.text.trim(),
                                  );
                                }
                              : null,
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(String sendedText) async {
    if (sendedText.isEmpty) return;
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      text: sendedText,
      uid: authService.user!.uid ?? '',
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _isWritting = false;
    });

    socketService?.emit('personal-msg', {
      'from': authService.user!.uid,
      'to': chatService.userTo!.uid,
      'msg': sendedText
    });
    if (AuthService.getToken() != null) {
      await chatService.sendMessageNotification(
        User(
          name: chatService.userTo!.name,
          email: chatService.userTo!.email,
          online: false,
          uid: '${chatService.userTo!.uid}',
        ),
      );
    }
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    socketService!.socket!.off('personal-msg');
    super.dispose();
  }
}

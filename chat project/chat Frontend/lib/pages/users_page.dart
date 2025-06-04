// ignore_for_file: sort_child_properties_last
import 'package:chat/pages/chat_page.dart';
import 'package:chat/services/push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/models/user.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/services/users_service.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final userService = UsersService();

  List<User> users = [];

  @override
  void initState() {
    pushNotificationService.messagesStream.listen(
      (message) {
        User user = User(
          uid: '${message['uid']}',
          name: '${message['name']}',
          email: '${message['email']}',
          online: false,
        );
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userTo = user;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
              value: chatService,
              child: ChatPage(),
            ),
          ),
        );
      },
    );
    _loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;

    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            user!.name,
            style: const TextStyle(color: Colors.white),
          ),
          elevation: 1,
          backgroundColor: const Color.fromRGBO(226, 174, 47, 1),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: socketService.serverStatus == ServerStatus.Offline
                  ? Icon(Icons.offline_bolt, color: Colors.red[400])
                  : Icon(Icons.check_circle, color: Colors.green[500]),
            ),
            IconButton(
              color: Colors.red,
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                socketService.disconnect();
                Navigator.pushReplacementNamed(context, 'login');
                AuthService.deleteToken();
              },
            ),
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _loadUsers,
          header: const WaterDropHeader(
            complete: Icon(
              Icons.check,
              color: Colors.green,
            ),
          ),
          child: _listViewUsers(),
        ),
      ),
    );
  }

  ListView _listViewUsers() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, i) => _userListTile(users[i]),
      separatorBuilder: (_, i) => const Divider(),
      itemCount: users.length,
    );
  }

  ListTile _userListTile(User user) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        child: Text(user.name.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: (user.online != null && user.online == true)
                ? Colors.green[300]
                : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userTo = user;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  void _loadUsers() async {
    //  await Future.delayed(const Duration(milliseconds: 1000));

    users = await userService.getUsers();

    setState(() {});

    _refreshController.refreshCompleted();
  }
}

import 'package:chat/models/user.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/services/push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/services/chat_service.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';

import 'package:chat/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await pushNotificationService.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => AuthService(),
    ),
    ChangeNotifierProvider(
      create: (_) => SocketService(),
    ),
    ChangeNotifierProvider(
      create: (_) => ChatService(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'chat',
      routes: appRoutes,
      theme: ThemeData.light(),
    );
  }
}

// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/users_page.dart';

import 'package:chat/services/auth_service.dart';
import 'package:chat/services/socket_service.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoadingState(context),
        builder: (context, snapshot) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.indigo,
            ),
          );
        },
      ),
    );
  }

  Future checkLoadingState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context);
    final authenticated = await authService.isLoggedIn();
    if (authenticated ?? false) {
      socketService.connect();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const UsersPage(),
          transitionDuration: const Duration(milliseconds: 0),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const LoginPage(),
          transitionDuration: const Duration(milliseconds: 0),
        ),
      );
    }
  }
}

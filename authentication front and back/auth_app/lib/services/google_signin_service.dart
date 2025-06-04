import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  static Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      final googleKey = await account!.authentication;

      print(account);
      print('==========ID TOKEN =============');
      print(googleKey.idToken);

      //TODO: llamar un servicio REST a nuestro backend con el idToken

      return account;
    } catch (error) {
      print('Error en Google SignIn');
      print(error);

      return null;
    }
  }

  static Future signOut() async {
    await _googleSignIn.signOut();
  }

  static Future<Widget> getAccount() async {
    return Text('${_googleSignIn.currentUser}');
  }
}

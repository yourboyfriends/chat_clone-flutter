import 'package:chat_flutter/pages/authgates/Auth_gates.dart';
import 'package:chat_flutter/pages/pages/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //khi nguoi dung dang nhap
        if (snapshot.hasData) {
          return HomePage();
        }
        //khi chua dang nhap
        else {
          return const AuthGate();
        }
      },
    ));
  }
}

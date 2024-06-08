import 'package:chat_flutter/pages/pages/login_pages.dart';
import 'package:chat_flutter/pages/pages/register_pages.dart';
import 'package:flutter/material.dart';

//chuyển đổi trang log và reg
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _authgatestate();
}

class _authgatestate extends State<AuthGate> {
  bool showlogin = true; // show trang login
  //nut chuyen doi log va register
  void authgates() {
    setState(() {
      showlogin = !showlogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showlogin) {
      return LoginPage(
        onTap: authgates,
      );
    } else {
      return RegisterPage(
        onTap: authgates,
      );
    }
  }
}

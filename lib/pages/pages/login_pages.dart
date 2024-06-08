import 'package:chat_flutter/pages/authgates/auth_service.dart';
import 'package:chat_flutter/pages/themes/button.dart';
import 'package:chat_flutter/pages/themes/text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key, required this.onTap}) : super(key: key);

  final void Function()? onTap;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  //ontap

  //auth service
  void Login(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailAndPassword(
          _emailController.text, _passWordController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 50,
            ),
            //text
            Text(
              "Chào mừng em đến với nhà của bọn anh",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 16),
            ),
            const SizedBox(
              height: 25,
            ),
            // email
            Mytextfield(
              hintText: "vui long nhap email",
              prefixIcon: Icon(Icons.email),
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(
              height: 10,
            ),
            //password
            Mytextfield(
              hintText: "vui long nhap mat khau",
              prefixIcon: Icon(Icons.lock),
              obscureText: true,
              controller: _passWordController,
            ),
            const SizedBox(
              height: 10,
            ),
            //button
            isButton(
              text: "login",
              onTap: () => Login(context),
            ),
            const SizedBox(
              height: 25,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("hay dang ky ngay bay h - "),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    " DANG KY",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

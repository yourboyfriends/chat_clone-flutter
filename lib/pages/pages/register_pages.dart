import 'package:chat_flutter/pages/authgates/auth_service.dart';
import 'package:chat_flutter/pages/themes/button.dart';
import 'package:chat_flutter/pages/themes/text_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key, required this.onTap}) : super(key: key);
  final void Function()? onTap;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _confimpassWordController =
      TextEditingController();

  void Register(BuildContext context) {
    final _auth = AuthService();
    // xac nhan mat khau
    if (_passWordController.text == _confimpassWordController.text) {
      try {
        _auth.signUpWithEmailAndPassword(
            _emailController.text, _passWordController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text('mat khau khong khop'),
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
              "Chào mừng em đến với nhà của bọn anh hãy đăng ký nào",
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
            //confimpassword
            Mytextfield(
              hintText: "xac nhan lai mat khau ",
              prefixIcon: Icon(Icons.lock_clock_outlined),
              obscureText: true,
              controller: _confimpassWordController,
            ),
            const SizedBox(
              height: 10,
            ),
            //button
            isButton(
              text: "Register",
              onTap: () => Register(context),
            ),
            const SizedBox(
              height: 25,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Ban da co mat khau ? "),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    " Login",
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

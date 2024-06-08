import 'package:chat_flutter/pages/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("setting page"),
        backgroundColor: Color.fromARGB(255, 3, 255, 255),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("dark mode"),
            Switch(
              value:
                  Provider.of<ThemeProvider>(context, listen: false).isdarkmode,
              onChanged: (value) =>
                  Provider.of<ThemeProvider>(context, listen: false).tryTheme(),
            ),
          ],
        ),
      ),
    );
  }
}

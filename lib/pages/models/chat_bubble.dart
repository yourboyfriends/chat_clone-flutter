// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_flutter/pages/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  ChatBubble({
    Key? key,
    required this.message,
    required this.isCurrentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // doi mau chat khi ow hai che doj light va dark
    bool isdarkmode =
        Provider.of<ThemeProvider>(context, listen: false).isdarkmode;
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser
            ? (isdarkmode ? Colors.green.shade600 : Colors.green.shade600)
            : (isdarkmode
                ? Colors.grey.shade800
                : Color.fromARGB(255, 236, 237, 238)),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 25),
      child: Text(
        message,
        style: TextStyle(
            color: isCurrentUser
                ? Colors.white
                : (isdarkmode ? Colors.white : Colors.black)),
      ),
    );
  }
}

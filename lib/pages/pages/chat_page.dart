// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chat_flutter/pages/authgates/auth_service.dart';
import 'package:chat_flutter/pages/chat/chat_service.dart';
import 'package:chat_flutter/pages/models/chat_bubble.dart';
import 'package:chat_flutter/pages/themes/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
//email nguoi nhan
  final String receiverEmail;
  final String receiverID;
  ChatPage({
    Key? key,
    required this.receiverEmail,
    required this.receiverID,
  }) : super(key: key);
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
// gui tin nhan
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, _messageController.text);

      // clear text
      _messageController.clear();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          //hien thi tin nhan
          Expanded(
            child: messList(),
          ),
          // nhap tin nhan
          _UserInput(),
        ],
      ),
    );
  }

  Widget messList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(receiverID, senderId),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text("ko tim thay doan chat");
          }
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            );
          }
          //list
          return ListView(
            children: snapshot.data!.docs.map((doc) => _MessItem(doc)).toList(),
          );
        });
  }

  Widget _MessItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//xac dinh nguoi dung hien tai
    bool isCurrentUser = data['sendId'] == _authService.getCurrentUser()!.uid;
// can chinh tin nhan khi nguoi dung nhan tin
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: data["message"],
            isCurrentUser: isCurrentUser,
          ),
        ],
      ),
    );
  }

  Widget _UserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Row(
        children: [
          Expanded(
            child: Mytextfield(
              hintText: "nhap tin nhan",
              prefixIcon: Icon(Icons.message),
              obscureText: false,
              controller: _messageController,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.cyan,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage,
              icon: Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

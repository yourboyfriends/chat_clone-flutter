import 'package:chat_flutter/pages/authgates/auth_service.dart';
import 'package:chat_flutter/pages/chat/chat_service.dart';
import 'package:chat_flutter/pages/pages/chat_page.dart';
import 'package:chat_flutter/pages/themes/drawer.dart';
import 'package:chat_flutter/pages/themes/user_title.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

// chat
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  // final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('homepage'),
        backgroundColor: Color.fromARGB(255, 3, 255, 255),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: const Drawerwidget(),
      body: _UserList(),
    );
  }

  // tạo danh sách người dùng
  Widget _UserList() => StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          // báo lỗi
          if (snapshot.hasError) {
            return const Text("ERROR");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("LOADING....");
          }
          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => _UserListItem(userData, context))
                .toList(),
          );
        },
      );
// hieenr thi ban be
  Widget _UserListItem(Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurrentUser()) {
      return UserTitle(
        text: userData["email"],
        //chuyển đến trang chat
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}

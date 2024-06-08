import 'package:chat_flutter/pages/models/mess.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //xem người dùng bằng stream
  /*
  {email:123456@gmail.com
  id:......

  }
  */
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //gui tin nhan
  Future<void> sendMessage(String receiverID, message) async {
    final String currentUserID =
        _auth.currentUser!.uid; // lay thong tin nguoi nhan
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    // tạo tin nhắn
    Message newMess = Message(
        sendId: currentUserID,
        sendEmail: currentUserEmail,
        receiverID: receiverID,
        message: message,
        timestamp: timestamp);
    // tao id phong chat
    List<String> Ids = [
      currentUserID,
      receiverID
    ]; // id nguowif dungf vaf id nguowi nhan
    Ids.sort(); // 1 phong chat se co 2 nguoi
    String ChatRoomId = Ids.join('_');
//them tin nhan vao fire base
    await _firestore
        .collection("chat_Room")
        .doc(ChatRoomId)
        .collection("message")
        .add(newMess.toMap());
  } // lay tin nhan

  Stream<QuerySnapshot> getMessages(String userID, otherId) {
    List<String> ids = [userID, otherId];
    ids.sort();
    String ChatRoomIds = ids.join('_');
    return _firestore
        .collection("chat_Room")
        .doc(ChatRoomIds)
        .collection("message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}

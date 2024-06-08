// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String sendId;
  final String sendEmail;
  final String receiverID;
  final String message;
  final Timestamp timestamp;
  Message({
    required this.sendId,
    required this.sendEmail,
    required this.receiverID,
    required this.message,
    required this.timestamp,
  });
  Map<String, dynamic> toMap() {
    return {
      'sendId': sendId,
      'sendEmail': receiverID,
      'received': receiverID,
      'message': message,
      'timestamp': timestamp,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealsapp/features/chat/domain/entities/chat_entiy.dart';

class ChatModel extends Chat {
  ChatModel(super.message, super.createdAt);
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      json['message'] ?? '',
      json['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'createdAt': createdAt,
    };
  }
}

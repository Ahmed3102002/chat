import 'package:chater/models/user_model.dart';

class ChatModel {
  final String id;
  List <UserModel>users = [];
  List chats = [];

  ChatModel({
    required this.id,
    required this.users,
    required this.chats,
  });
  factory ChatModel.fromjson(chats){
    return ChatModel(id: chats['id'], users: chats['users'], chats: chats['chats']);
  }
}

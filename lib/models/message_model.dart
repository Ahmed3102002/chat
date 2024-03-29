class MessageModel {
  final String message;
  final String senderId;
  final String time;

  MessageModel(
      {required this.time, required this.message, required this.senderId});
  factory MessageModel.fromjson(messages) {
    return MessageModel(
        senderId: messages['sender'],
        message: messages['message'],
        time: messages['time']);
  }
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'sender': senderId,
      'time': time,
    };
  }
}

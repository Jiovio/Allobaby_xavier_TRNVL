class ChatMessage {
    String? senderId;
  String? receiverId;
  String? type;
  String? message;
  DateTime? timestamp;
  String? photoUrl;


    ChatMessage(
      {this.senderId,
      this.receiverId,
      this.type,
      this.message,
      this.timestamp});



}
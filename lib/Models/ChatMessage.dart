class Messages {
  String? senderId;
  String? receiverId;
  String? type;
  String? message;
  DateTime? timestamp;
  String? photoUrl;
  String? fileUrl;
  String? fileSize;
  String? fileName;

  Messages(
      {this.senderId,
      this.receiverId,
      this.type,
      this.message,
      this.timestamp});

  //Will be only called when you wish to send an image
  // named constructor
  Messages.imageMessage(
      {this.senderId,
      this.receiverId,
      this.message,
      this.type,
      this.timestamp,
      this.photoUrl});

  //Will be only called when you wish to send an file
  Messages.fileMessage(
      {this.senderId,
      this.receiverId,
      this.message,
      this.type,
      this.timestamp,
      this.fileUrl,
      this.fileName,
      this.fileSize});

  Map toMap() {
    var map = Map<String, dynamic>();
    map['senderId'] = this.senderId;
    map['receiverId'] = this.receiverId;
    map['type'] = this.type;
    map['message'] = this.message;
    map['timestamp'] = this.timestamp;
    return map;
  }

  Map toImageMap() {
    var map = Map<String, dynamic>();
    map['message'] = this.message;
    map['senderId'] = this.senderId;
    map['receiverId'] = this.receiverId;
    map['type'] = this.type;
    map['timestamp'] = this.timestamp;
    map['photoUrl'] = this.photoUrl;
    return map;
  }

  Map toFileMap() {
    var map = Map<String, dynamic>();
    map['message'] = this.message;
    map['senderId'] = this.senderId;
    map['receiverId'] = this.receiverId;
    map['type'] = this.type;
    map['timestamp'] = this.timestamp;
    map['fileUrl'] = this.fileUrl;
    map['fileSize'] = this.fileSize;
    map['fileName'] = this.fileName;
    return map;
  }

  // named constructor
  Messages.fromMap(Map<String, dynamic> map) {
    this.senderId = map['senderId'];
    this.receiverId = map['receiverId'];
    this.type = map['type'];
    this.message = map['message'];
    this.timestamp = DateTime.parse(map['timestamp']) ;
    this.photoUrl = map['photoUrl'];
    this.fileUrl = map['fileUrl'];
    this.fileSize = map['fileSize'];
    this.fileName = map['fileName'];
  }
}


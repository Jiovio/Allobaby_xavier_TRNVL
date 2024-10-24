class Messages {
  String? id; // New field
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
      {this.id, // New field in constructor
      this.senderId,
      this.receiverId,
      this.type,
      this.message,
      this.timestamp,
      this.photoUrl});

  // Named constructor for image messages
  Messages.imageMessage(
      {this.id, // New field in constructor
      this.senderId,
      this.receiverId,
      this.message,
      this.type,
      this.timestamp,
      this.photoUrl});

  // Named constructor for file messages
  Messages.fileMessage(
      {this.id, // New field in constructor
      this.senderId,
      this.receiverId,
      this.message,
      this.type,
      this.timestamp,
      this.fileUrl,
      this.fileName,
      this.fileSize});

  // Convert regular message to map
  Map toMap() {
    var map = Map<String, dynamic>();
    map['id'] = this.id; // Include new field
    map['senderId'] = this.senderId;
    map['receiverId'] = this.receiverId;
    map['type'] = this.type;
    map['message'] = this.message;
    map['timestamp'] = this.timestamp?.toIso8601String();
    return map;
  }

  // Convert image message to map
  Map toImageMap() {
    var map = Map<String, dynamic>();
    map['id'] = this.id; // Include new field
    map['message'] = this.message;
    map['senderId'] = this.senderId;
    map['receiverId'] = this.receiverId;
    map['type'] = this.type;
    map['timestamp'] = this.timestamp?.toIso8601String();
    map['photoUrl'] = this.photoUrl;
    return map;
  }

  // Convert file message to map
  Map toFileMap() {
    var map = Map<String, dynamic>();
    map['id'] = this.id; // Include new field
    map['message'] = this.message;
    map['senderId'] = this.senderId;
    map['receiverId'] = this.receiverId;
    map['type'] = this.type;
    map['timestamp'] = this.timestamp?.toIso8601String();
    map['fileUrl'] = this.fileUrl;
    map['fileSize'] = this.fileSize;
    map['fileName'] = this.fileName;
    return map;
  }

  // Named constructor to create Message from map
  Messages.fromMap(Map<String, dynamic> map) {
    this.id = map['id']; // Include new field
    this.senderId = map['senderId'];
    this.receiverId = map['receiverId'];
    this.type = map['type'];
    this.message = map['message'];
    this.timestamp = DateTime.parse(map['timestamp']);
    this.photoUrl = map['photoUrl'];
    this.fileUrl = map['fileUrl'];
    this.fileSize = map['fileSize'];
    this.fileName = map['fileName'];
  }

  // Static method to convert list of maps to list of Messages
  static List<Messages> fromMapList(List<Map<String, dynamic>> mapList) {
    return mapList.map((map) => Messages.fromMap(map)).toList();
  }
}




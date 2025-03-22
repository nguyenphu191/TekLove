class Message {
  final dynamic sender;
  final dynamic receiver;
  final String content;
  final List<String> imageUrl;
  final DateTime createdAt;
  final bool isread;

  Message({
    required this.sender,
    required this.receiver,
    required this.content,
    this.imageUrl = const [],
    required this.createdAt,
    required this.isread,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: json['sender'],
      receiver: json['receiver'],
      content: json['content'],
      imageUrl:
          (json['imageUrl'] as List<dynamic>).map((e) => e.toString()).toList(),
      createdAt: DateTime.parse(json['createdAt']),
      isread: json['isread'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'receiver': receiver,
      'content': content,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'isread': isread,
    };
  }
}

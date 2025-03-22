class Love {
  final Map<String, dynamic> sender;
  final Map<String, dynamic> receiver;
  final String status;
  final int attendence;
  final DateTime createdAt;
  final DateTime updatedAt;

  Love({
    required this.sender,
    required this.receiver,
    this.status = 'no',
    this.attendence = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  // Chuyển đổi từ JSON sang object Love
  factory Love.fromJson(Map<String, dynamic> json) {
    return Love(
      sender: json['sender'] as Map<String, dynamic>,
      receiver: json['receiver'] as Map<String, dynamic>,
      status: json['status'] ?? 'no',
      attendence: json['attendence'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Chuyển đổi từ object Love sang JSON
  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'receiver': receiver,
      'status': status,
      'attendence': attendence,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

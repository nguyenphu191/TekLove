class Account {
  String id;
  String phone;
  String password;
  int numberLike;
  int numberSuperLike;
  int numberSpeed;
  bool premium;
  DateTime? datePremium;
  String? otp;
  DateTime? otpExpires;
  bool isActive;
  bool isOn;

  Account({
    required this.id,
    required this.phone,
    required this.password,
    this.numberLike = 10,
    this.numberSuperLike = 3,
    this.numberSpeed = 0,
    this.premium = false,
    this.datePremium,
    this.otp,
    this.otpExpires,
    this.isActive = false,
    this.isOn = false,
  });

  /// Chuyển từ JSON (Map) sang đối tượng Account
  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['_id'] ?? '',
      phone: json['phone'] ?? '',
      password: json['password'] ?? '',
      numberLike: json['numberlike'] ?? 10,
      numberSuperLike: json['numbersuperlike'] ?? 3,
      numberSpeed: json['numberspeed'] ?? 0,
      premium: json['premium'] ?? false,
      datePremium: json['datePremium'] != null
          ? DateTime.parse(json['datePremium'])
          : null,
      otp: json['otp'],
      otpExpires: json['otpExpires'] != null
          ? DateTime.parse(json['otpExpires'])
          : null,
      isActive: json['isActive'] ?? false,
      isOn: json['isOn'] ?? false,
    );
  }

  /// Chuyển từ đối tượng Account sang JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'password': password,
      'numberlike': numberLike,
      'numbersuperlike': numberSuperLike,
      'numberspeed': numberSpeed,
      'premium': premium,
      'datePremium': datePremium?.toIso8601String(),
      'otp': otp,
      'otpExpires': otpExpires?.toIso8601String(),
      'isActive': isActive,
      'isOn': isOn,
    };
  }
}

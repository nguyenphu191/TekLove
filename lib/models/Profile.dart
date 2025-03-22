class Profile {
  final String accountId;
  final String name;
  final String? avatar;
  final String? slogen;
  final String? livingAddress;
  final List<String> images;
  final String gender;
  final String genderLike;
  final String birthday;
  final String findFor;
  final String sexual;
  final int priorityDistance;
  final String? university;
  final dynamic habits;
  final List<String> interests;
  final bool showGenderInProfile;
  final bool showSexInProfile;
  final dynamic wholikeyou;
  final dynamic whoyoulike;
  final dynamic whosuperlikeyou;
  final dynamic whoyousuperlike;
  final dynamic whoyouskip;
  final bool isLove;
  final int? weight;
  final String? height;
  final List<String> voices;
  final List<String> videos;
  final Location? location;
  final num? profileCompletion;
  final bool verified;
  final bool isSpeed;
  final DateTime? expireSpeed;
  final String? job;
  final String? company;
  final dynamic MoreInfor;
  final String? introduction;
  final List<String>? language;

  Profile({
    required this.accountId,
    required this.name,
    this.avatar = "noinfo",
    this.images = const [],
    required this.gender,
    required this.genderLike,
    required this.birthday,
    required this.findFor,
    required this.priorityDistance,
    this.university = "noinfo",
    this.habits,
    this.interests = const [],
    required this.showGenderInProfile,
    required this.showSexInProfile,
    required this.sexual,
    this.wholikeyou,
    this.whoyoulike,
    this.whosuperlikeyou,
    this.whoyousuperlike,
    this.whoyouskip,
    this.isLove = false,
    this.weight,
    this.height,
    this.voices = const [],
    this.videos = const [],
    this.location,
    this.profileCompletion,
    this.verified = false,
    this.isSpeed = false,
    this.expireSpeed,
    this.livingAddress = "noinfo",
    this.slogen = "noinfo",
    this.job = "noinfo",
    this.company = "noinfo",
    this.MoreInfor = const {},
    this.introduction = 'noinfo',
    this.language = const [],
  });

  /// Chuyển từ JSON sang đối tượng Account
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      accountId: json['accountId'],
      name: json['name'],
      avatar: json['avatar'] ?? "noinfo",
      images: List<String>.from(json['images'] ?? []),
      gender: json['gender'],
      genderLike: json['genderlike'],
      birthday: json['birthday'],
      findFor: json['findfor'],
      sexual: json['sexuality'],
      showGenderInProfile: json['showGenderInProfile'],
      showSexInProfile: json['showSexInProfile'],
      priorityDistance: json['priorityDistance'],
      university: json['university'],
      habits: json['habits'],
      interests:
          json['interests'] != null ? List<String>.from(json['interests']) : [],
      wholikeyou: json['wholikeyou'],
      whoyoulike: json['whoyoulike'],
      whosuperlikeyou: json['whosuperlikeyou'],
      whoyousuperlike: json['whoyousuperlike'],
      whoyouskip: json['whoyouskip'],
      isLove: json['isLove'] ?? false,
      weight: json['weight'],
      height: json['height'],
      voices: List<String>.from(json['voices'] ?? []),
      videos: List<String>.from(json['videos'] ?? []),
      location: Location.fromJson(json['location']),
      profileCompletion: json['profileCompletion'],
      verified: json['verified'] ?? false,
      isSpeed: json['isSpeed'] ?? false,
      expireSpeed: json['expireSpeed'] != null
          ? DateTime.parse(json['expireSpeed'])
          : null,
      livingAddress: json['livingAddress'] ?? "noinfo",
      slogen: json['slogen'] ?? "noinfo",
      job: json['job'] ?? "noinfo",
      company: json['company'] ?? "noinfo",
      MoreInfor: json['moreInfor'] ?? {},
      introduction: json['introduction'] ?? 'noinfo',
      language:
          json['language'] != null ? List<String>.from(json['language']) : [],
    );
  }

  /// Chuyển từ đối tượng Profile sang JSON
  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'name': name,
      'avatar': avatar,
      'images': images,
      'gender': gender,
      'genderlike': genderLike,
      'birthday': birthday,
      'findfor': findFor,
      'sexuality': sexual,
      'showGenderInProfile': showGenderInProfile,
      'showSexInProfile': showSexInProfile,
      'priorityDistance': priorityDistance,
      'university': university,
      'habits': habits,
      'interests': interests,
      'wholikeyou': wholikeyou,
      'whoyoulike': whoyoulike,
      'whosuperlikeyou': whosuperlikeyou,
      'whoyousuperlike': whoyousuperlike,
      'whoyouskip': whoyouskip,
      'isLove': isLove,
      'weight': weight,
      'height': height,
      'voices': voices,
      'videos': videos,
      'location': location?.toJson(),
      'profileCompletion': profileCompletion,
      'verified': verified,
      'isSpeed': isSpeed,
      'expireSpeed': expireSpeed?.toIso8601String(),
      'livingAddress': livingAddress,
      'slogen': slogen,
      'job': job,
      'company': company,
      'moreInfor': MoreInfor,
      'introduction': introduction,
      'language': language,
    };
  }

  @override
  String toString() {
    return toJson().toString(); // In ra JSON khi debug
  }
}

/// Model cho vị trí (latitude & longitude)
class Location {
  final double latitude;
  final double longitude;

  Location({required this.latitude, required this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: (json['latitude'] is int)
          ? (json['latitude'] as int).toDouble()
          : json['latitude'],
      longitude: (json['longitude'] is int)
          ? (json['longitude'] as int).toDouble()
          : json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

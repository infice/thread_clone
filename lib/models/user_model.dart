class User {
  final String id;
  final String username;
  final String displayName;
  final String? profileImage;
  final String? bio;
  final int followersCount;
  final int followingCount;
  final bool isVerified;
  final bool isFollowing;

  User({
    required this.id,
    required this.username,
    required this.displayName,
    this.profileImage,
    this.bio,
    this.followersCount = 0,
    this.followingCount = 0,
    this.isVerified = false,
    this.isFollowing = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      displayName: json['displayName'],
      profileImage: json['profileImage'],
      bio: json['bio'],
      followersCount: json['followersCount'] ?? 0,
      followingCount: json['followingCount'] ?? 0,
      isVerified: json['isVerified'] ?? false,
      isFollowing: json['isFollowing'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'displayName': displayName,
      'profileImage': profileImage,
      'bio': bio,
      'followersCount': followersCount,
      'followingCount': followingCount,
      'isVerified': isVerified,
      'isFollowing': isFollowing,
    };
  }
}

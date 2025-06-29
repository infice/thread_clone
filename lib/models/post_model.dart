import 'user_model.dart';

class Post {
  final String id;
  final User author;
  final String content;
  final List<String>? images;
  final DateTime createdAt;
  final int likesCount;
  final int repliesCount;
  final int repostsCount;
  final bool isLiked;
  final bool isReposted;
  final Post? repostedPost;
  final Post? replyTo;

  Post({
    required this.id,
    required this.author,
    required this.content,
    this.images,
    required this.createdAt,
    this.likesCount = 0,
    this.repliesCount = 0,
    this.repostsCount = 0,
    this.isLiked = false,
    this.isReposted = false,
    this.repostedPost,
    this.replyTo,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      author: User.fromJson(json['author']),
      content: json['content'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      createdAt: DateTime.parse(json['createdAt']),
      likesCount: json['likesCount'] ?? 0,
      repliesCount: json['repliesCount'] ?? 0,
      repostsCount: json['repostsCount'] ?? 0,
      isLiked: json['isLiked'] ?? false,
      isReposted: json['isReposted'] ?? false,
      repostedPost:
          json['repostedPost'] != null
              ? Post.fromJson(json['repostedPost'])
              : null,
      replyTo: json['replyTo'] != null ? Post.fromJson(json['replyTo']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author.toJson(),
      'content': content,
      'images': images,
      'createdAt': createdAt.toIso8601String(),
      'likesCount': likesCount,
      'repliesCount': repliesCount,
      'repostsCount': repostsCount,
      'isLiked': isLiked,
      'isReposted': isReposted,
      'repostedPost': repostedPost?.toJson(),
      'replyTo': replyTo?.toJson(),
    };
  }
}

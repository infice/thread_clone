import '../models/post_model.dart';
import '../models/user_model.dart';

class MockDataService {
  static List<Post> getFeedPosts() {
    return [
      Post(
        id: '1',
        author: User(
          id: 'user1',
          username: 'markzuckerberg',
          displayName: 'Mark Zuckerberg',
          profileImage: null,
          isVerified: true,
        ),
        content: 'Excited to share the latest updates on our AI initiatives!',
        images: [],
        createdAt: DateTime.now().subtract(Duration(hours: 2)),
        likesCount: 1247,
        repliesCount: 89,
        repostsCount: 234,
        isLiked: false,
        isReposted: false,
        repostedPost: null,
        replyTo: null,
      ),
      Post(
        id: '2',
        author: User(
          id: 'user2',
          username: 'elonmusk',
          displayName: 'Elon Musk',
          profileImage: null,
          isVerified: true,
        ),
        content: 'Tesla production numbers looking great this quarter! 🚗⚡',
        images: [],
        createdAt: DateTime.now().subtract(Duration(hours: 4)),
        likesCount: 2156,
        repliesCount: 156,
        repostsCount: 432,
        isLiked: true,
        isReposted: false,
        repostedPost: null,
        replyTo: null,
      ),
      Post(
        id: '3',
        author: User(
          id: 'user3',
          username: 'sundarpichai',
          displayName: 'Sundar Pichai',
          profileImage: null,
          isVerified: true,
        ),
        content: 'Google I/O was incredible this year. So many exciting announcements!',
        images: [],
        createdAt: DateTime.now().subtract(Duration(hours: 6)),
        likesCount: 892,
        repliesCount: 67,
        repostsCount: 123,
        isLiked: false,
        isReposted: true,
        repostedPost: null,
        replyTo: null,
      ),
    ];
  }

  static List<User> getUsers() {
    return [
      User(
        id: 'user1',
        username: 'markzuckerberg',
        displayName: 'Mark Zuckerberg',
        profileImage: null,
        isVerified: true,
      ),
      User(
        id: 'user2',
        username: 'elonmusk',
        displayName: 'Elon Musk',
        profileImage: null,
        isVerified: true,
      ),
      User(
        id: 'user3',
        username: 'sundarpichai',
        displayName: 'Sundar Pichai',
        profileImage: null,
        isVerified: true,
      ),
    ];
  }
}

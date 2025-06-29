import '../models/user_model.dart';
import '../models/post_model.dart';

class MockDataService {
  static final List<User> _users = [
    User(
      id: '1',
      username: 'zuck',
      displayName: 'Mark Zuckerberg',
      profileImage: 'https://i.pravatar.cc/150?u=zuck',
      bio: 'Building the metaverse',
      followersCount: 15000000,
      followingCount: 500,
      isVerified: true,
    ),
    User(
      id: '2',
      username: 'elonmusk',
      displayName: 'Elon Musk',
      profileImage: 'https://i.pravatar.cc/150?u=elonmusk',
      bio: 'Mars, here we come!!',
      followersCount: 18000000,
      followingCount: 300,
      isVerified: true,
    ),
    User(
      id: '3',
      username: 'sundarpichai',
      displayName: 'Sundar Pichai',
      profileImage: 'https://i.pravatar.cc/150?u=sundarpichai',
      bio: 'CEO of Google and Alphabet',
      followersCount: 8000000,
      followingCount: 200,
      isVerified: true,
    ),
    User(
      id: '4',
      username: 'satyanadella',
      displayName: 'Satya Nadella',
      profileImage: 'https://i.pravatar.cc/150?u=satyanadella',
      bio: 'CEO of Microsoft',
      followersCount: 5000000,
      followingCount: 150,
      isVerified: true,
    ),
    User(
      id: '5',
      username: 'timcook',
      displayName: 'Tim Cook',
      profileImage: 'https://i.pravatar.cc/150?u=timcook',
      bio: 'CEO of Apple',
      followersCount: 12000000,
      followingCount: 100,
      isVerified: true,
    ),
  ];

  static final List<Post> _posts = [
    Post(
      id: '1',
      author: _users[0],
      content:
          'Just launched Threads! 🚀 The future of social media is here. What do you think?',
      createdAt: DateTime.now().subtract(Duration(hours: 2)),
      likesCount: 15420,
      repliesCount: 2340,
      repostsCount: 890,
    ),
    Post(
      id: '2',
      author: _users[1],
      content:
          'Threads is interesting. The integration with Instagram is smart. 👏',
      createdAt: DateTime.now().subtract(Duration(hours: 1)),
      likesCount: 8920,
      repliesCount: 1560,
      repostsCount: 450,
    ),
    Post(
      id: '3',
      author: _users[2],
      content:
          'Competition is good for innovation. Welcome to the space, Threads!',
      createdAt: DateTime.now().subtract(Duration(minutes: 45)),
      likesCount: 5670,
      repliesCount: 890,
      repostsCount: 230,
    ),
    Post(
      id: '4',
      author: _users[3],
      content:
          'The tech industry is evolving rapidly. Threads brings a fresh perspective to social networking.',
      createdAt: DateTime.now().subtract(Duration(minutes: 30)),
      likesCount: 3450,
      repliesCount: 567,
      repostsCount: 123,
    ),
    Post(
      id: '5',
      author: _users[4],
      content:
          'Innovation happens when great minds compete. Looking forward to seeing how Threads evolves.',
      createdAt: DateTime.now().subtract(Duration(minutes: 15)),
      likesCount: 6780,
      repliesCount: 1120,
      repostsCount: 340,
    ),
    Post(
      id: '6',
      author: _users[0],
      content:
          'Thank you everyone for the amazing response! Threads is just getting started. More features coming soon! 🔥',
      images: ['https://picsum.photos/seed/picsum/400/300'],
      createdAt: DateTime.now().subtract(Duration(minutes: 5)),
      likesCount: 23450,
      repliesCount: 3450,
      repostsCount: 1200,
    ),
  ];

  static List<User> getUsers() {
    return _users;
  }

  static List<Post> getPosts() {
    return _posts;
  }

  static User getCurrentUser() {
    return _users[0]; // Mark Zuckerberg as current user
  }

  static List<Post> getFeedPosts() {
    return _posts;
  }

  static List<User> getSuggestions() {
    return _users.where((user) => user.id != '1').toList();
  }
}

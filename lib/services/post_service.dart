import '../models/post_model.dart';
import '../models/user_model.dart';
import 'mock_data_service.dart';

abstract class IPostService {
  Future<List<Post>> fetchPosts();
  Future<void> createPost({required String content, String? imagePath});
}

class MockPostService implements IPostService {
  // Store posts in memory (simulating database)
  final List<Post> _posts = [];

  MockPostService() {
    // Initialize with mock data
    _posts.addAll(MockDataService.getFeedPosts());
  }

  @override
  Future<List<Post>> fetchPosts() async {
    // Return all posts
    return _posts;
  }

  @override
  Future<void> createPost({required String content, String? imagePath}) async {
    // Mock: ถ้ามี imagePath ให้แทนที่ด้วย URL จริง (สมมุติอัปโหลดแล้วได้ URL)
    final String? mockImageUrl =
        imagePath != null
            ? 'https://images.unsplash.com/photo-1506744038136-46273834b3fb'
            : null;
    // Create a new post
    final newPost = Post(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      author: User(
        id: 'current_user',
        username: 'user',
        displayName: 'User Name',
        profileImage: null,
        isVerified: false,
      ),
      content: content,
      images: mockImageUrl != null ? [mockImageUrl] : [],
      createdAt: DateTime.now(),
      likesCount: 0,
      repliesCount: 0,
      repostsCount: 0,
      isLiked: false,
      isReposted: false,
      repostedPost: null,
      replyTo: null,
    );
    // Add to the beginning of the posts list
    _posts.insert(0, newPost);
    // Simulate API delay
    await Future.delayed(Duration(milliseconds: 500));
  }
}

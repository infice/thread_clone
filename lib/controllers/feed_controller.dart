import 'package:get/get.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';
import '../services/mock_data_service.dart';

class FeedController extends GetxController {
  final RxList<Post> posts = <Post>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFeed();
  }

  void loadFeed() {
    isLoading.value = true;
    // Simulate API call delay
    Future.delayed(Duration(milliseconds: 500), () {
      posts.value = MockDataService.getFeedPosts();
      isLoading.value = false;
    });
  }

  void likePost(String postId) {
    final postIndex = posts.indexWhere((post) => post.id == postId);
    if (postIndex != -1) {
      final post = posts[postIndex];
      final updatedPost = Post(
        id: post.id,
        author: post.author,
        content: post.content,
        images: post.images,
        createdAt: post.createdAt,
        likesCount: post.isLiked ? post.likesCount - 1 : post.likesCount + 1,
        repliesCount: post.repliesCount,
        repostsCount: post.repostsCount,
        isLiked: !post.isLiked,
        isReposted: post.isReposted,
        repostedPost: post.repostedPost,
        replyTo: post.replyTo,
      );
      posts[postIndex] = updatedPost;
    }
  }

  void repost(String postId) {
    final postIndex = posts.indexWhere((post) => post.id == postId);
    if (postIndex != -1) {
      final post = posts[postIndex];
      final updatedPost = Post(
        id: post.id,
        author: post.author,
        content: post.content,
        images: post.images,
        createdAt: post.createdAt,
        likesCount: post.likesCount,
        repliesCount: post.repliesCount,
        repostsCount:
            post.isReposted ? post.repostsCount - 1 : post.repostsCount + 1,
        isLiked: post.isLiked,
        isReposted: !post.isReposted,
        repostedPost: post.repostedPost,
        replyTo: post.replyTo,
      );
      posts[postIndex] = updatedPost;
    }
  }

  void refreshFeed() {
    loadFeed();
  }

  Future<void> createPost({required String content, String? imagePath}) async {
    // Create a new post
    final newPost = Post(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      author: User(
        id: 'current_user',
        username: 'username',
        displayName: 'User Name',
        profileImage: null,
        isVerified: false,
      ),
      content: content,
      images: imagePath != null ? [imagePath] : [],
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
    posts.insert(0, newPost);
  }
}

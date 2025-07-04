import 'package:get/get.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';
import '../services/mock_data_service.dart';
import '../services/post_service.dart';

class FeedController extends GetxController {
  final IPostService postService;
  FeedController(this.postService);

  final RxList<Post> posts = <Post>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFeed();
  }

  Future<void> loadFeed() async {
    isLoading.value = true;
    posts.value = await postService.fetchPosts();
    isLoading.value = false;
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

  Future<void> createPost({required String content, String? imagePath}) async {
    await postService.createPost(content: content, imagePath: imagePath);
    await loadFeed();
  }

  Future<void> refreshFeed() async {
    await loadFeed();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/feed_controller.dart';
import '../widgets/post_card.dart';
import '../utils/constants.dart';
import 'create_post_view.dart';

class FeedView extends StatelessWidget {
  final FeedController controller = Get.put(FeedController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      title: const Icon(
        IconData(0xe35e, fontFamily: 'MaterialIcons'),
        color: AppColors.primary,
        size: 32,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.add_box_outlined, color: AppColors.primary),
          onPressed: () {
            Get.to(() => CreatePostView());
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      return RefreshIndicator(
        onRefresh: () async {
          controller.refreshFeed();
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildCreatePostTile()),
            if (controller.posts.isEmpty)
              SliverFillRemaining(child: _buildEmptyFeed())
            else
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return PostCard(post: controller.posts[index]);
                }, childCount: controller.posts.length),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildCreatePostTile() {
    return GestureDetector(
      onTap: () => Get.to(() => CreatePostView()),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.padding,
          vertical: AppSizes.padding,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.border, width: 0.8),
          ),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: AppSizes.avatarSize / 2,
              backgroundColor: AppColors.secondary,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: AppSizes.padding),
            Text('What\'s new?', style: AppTextStyles.caption),
            const Spacer(),
            const Icon(Icons.image_outlined, color: AppColors.secondary),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyFeed() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.feed_outlined, size: 64, color: AppColors.secondary),
          SizedBox(height: AppSizes.padding),
          Text(
            'No posts yet',
            style: AppTextStyles.body.copyWith(color: AppColors.secondary),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.to(() => CreatePostView());
      },
      backgroundColor: AppColors.primary,
      child: Icon(Icons.edit, color: Colors.white),
    );
  }
}

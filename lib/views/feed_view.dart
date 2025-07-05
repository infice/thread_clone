import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/feed_controller.dart';
import '../widgets/post_card.dart';
import '../widgets/threads_icon_cdn.dart';
import '../utils/constants.dart';
import 'create_post_view.dart';

class FeedView extends GetView<FeedController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      title: ThreadsIconCDN(size: 32),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            Icons.add_box_outlined,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Get.to(() => CreatePostView());
          },
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
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
            SliverToBoxAdapter(child: _buildCreatePostTile(context)),
            if (controller.posts.isEmpty)
              SliverFillRemaining(child: _buildEmptyFeed(context))
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

  Widget _buildCreatePostTile(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => CreatePostView()),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.padding,
          vertical: AppSizes.padding,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.8,
            ),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: AppSizes.avatarSize / 2,
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: AppSizes.padding),
            Text(
              'whats_new'.tr,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontSize: 16),
            ),
            const Spacer(),
            Icon(
              Icons.image_outlined,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyFeed(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.feed_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: AppSizes.padding),
          Text(
            'no_posts'.tr,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Get.to(() => CreatePostView());
      },
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(Icons.edit, color: Colors.white),
    );
  }
}

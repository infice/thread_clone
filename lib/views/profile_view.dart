import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/feed_controller.dart';
import '../models/user_model.dart';
import '../widgets/post_card.dart';
import '../utils/constants.dart';
import '../views/settings_view.dart';
import '../bindings/settings_binding.dart';

class ProfileView extends GetView<AuthController> {
  final FeedController feedController = Get.find<FeedController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      title: Text('profile'.tr, style: TextStyle(
        color: Theme.of(context).textTheme.titleLarge?.color,
      )),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.settings, color: Theme.of(context).primaryColor),
          onPressed: () {
            Get.toNamed('/settings');
          },
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.padding),
      child: Column(
        children: [
          _buildProfileHeader(context),
          const SizedBox(height: AppSizes.padding * 2),
          _buildStatsSection(context),
          const SizedBox(height: AppSizes.padding * 2),
          _buildActionButtons(context),
          _buildUserPosts(context),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.person, size: 50, color: Colors.white),
        ),
        const SizedBox(height: AppSizes.padding),
        Text(
          'John Doe',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '@johndoe',
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        const SizedBox(height: AppSizes.padding),
        Text(
          'Flutter Developer | Coffee Lover | Tech Enthusiast',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem(context, 'posts'.tr, '42'),
        _buildStatItem(context, 'followers'.tr, '1.2K'),
        _buildStatItem(context, 'following'.tr, '890'),
      ],
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Edit profile action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text('edit_profile'.tr, style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(height: AppSizes.padding),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              controller.logout();
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Theme.of(context).primaryColor),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text('logout'.tr, style: TextStyle(
              color: Theme.of(context).primaryColor,
            )),
          ),
        ),
      ],
    );
  }

  Widget _buildUserPosts(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizes.padding),
            child: Text(
              'Your Posts',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
          ),
          Obx(() {
            if (feedController.isLoading.value) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.padding),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final userPosts =
                feedController.posts
                    .where((post) => post.author.id == 'current_user')
                    .toList();

            if (userPosts.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.padding),
                  child: Column(
                    children: [
                      Icon(
                        Icons.post_add_outlined,
                        size: 64,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No posts yet',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Start sharing your thoughts!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: userPosts.length,
              itemBuilder: (context, index) {
                return PostCard(post: userPosts[index]);
              },
            );
          }),
        ],
      ),
    );
  }
}

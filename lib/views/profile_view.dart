import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/feed_controller.dart';
import '../models/user_model.dart';
import '../widgets/post_card.dart';
import '../utils/constants.dart';

class ProfileView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final FeedController feedController = Get.find<FeedController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      title: Text('Profile', style: AppTextStyles.heading),
      actions: [
        IconButton(
          icon: Icon(Icons.settings, color: AppColors.primary),
          onPressed: () {
            // Handle settings
          },
        ),
        IconButton(
          icon: Icon(Icons.logout, color: AppColors.primary),
          onPressed: () => authController.logout(),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProfileHeader(),
          _buildProfileStats(),
          _buildProfileActions(),
          _buildUserPosts(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(AppSizes.padding),
      child: Column(
        children: [
          // Profile Image
          CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.primary,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          SizedBox(height: 16),

          // User Info
          Text(
            'User Name',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '@username',
            style: TextStyle(fontSize: 16, color: AppColors.secondary),
          ),
          SizedBox(height: 12),

          // Bio
          Text(
            'This is a sample bio for the user. You can add your own bio here.',
            style: TextStyle(fontSize: 16, color: AppColors.text),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStats() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('Posts', '42'),
          _buildStatItem('Followers', '1.2K'),
          _buildStatItem('Following', '890'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 14, color: AppColors.secondary)),
      ],
    );
  }

  Widget _buildProfileActions() {
    return Container(
      padding: EdgeInsets.all(AppSizes.padding),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                // Handle edit profile
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Edit Profile',
                style: TextStyle(
                  color: AppColors.text,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Handle share profile
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Share Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserPosts() {
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
                color: AppColors.text,
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
                        color: AppColors.secondary,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No posts yet',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.secondary,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Start sharing your thoughts!',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.secondary,
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

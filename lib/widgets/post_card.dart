import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/post_model.dart';
import '../controllers/feed_controller.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final FeedController controller = Get.find<FeedController>();

  PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.smallPadding,
        horizontal: AppSizes.padding,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor, width: 0.8),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatarColumn(),
          const SizedBox(width: AppSizes.padding),
          _buildPostContent(context),
        ],
      ),
    );
  }

  Widget _buildAvatarColumn() {
    return Column(
      children: [
        CircleAvatar(
          radius: AppSizes.avatarSize / 2,
          backgroundImage:
              post.author.profileImage != null
                  ? CachedNetworkImageProvider(post.author.profileImage!)
                  : null,
          child:
              post.author.profileImage == null
                  ? Text(
                    post.author.displayName[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                  : null,
        ),
        // You can add the vertical line here if needed
      ],
    );
  }

  Widget _buildPostContent(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 4),
          Text(post.content, style: Theme.of(context).textTheme.bodyMedium),
          if (post.images != null && post.images!.isNotEmpty) _buildImages(),
          const SizedBox(height: AppSizes.padding),
          _buildActions(),
          const SizedBox(height: AppSizes.smallPadding),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Text(
          post.author.displayName,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (post.author.isVerified) ...[
          const SizedBox(width: 4),
          Icon(Icons.verified, size: 16, color: AppColors.verified),
        ],
        const Spacer(),
        Text(
          Formatters.formatTimeAgo(post.createdAt),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(width: AppSizes.smallPadding),
        const Icon(Icons.more_horiz, color: AppColors.primary),
      ],
    );
  }

  Widget _buildImages() {
    return Container(
      margin: const EdgeInsets.only(top: AppSizes.padding),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        child: CachedNetworkImage(
          imageUrl: post.images!.first,
          fit: BoxFit.cover,
          placeholder:
              (context, url) => Container(
                color: AppColors.surface,
                child: const Center(child: CircularProgressIndicator()),
              ),
          errorWidget:
              (context, url, error) =>
                  const Icon(Icons.error, color: AppColors.secondary),
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildActionButton(
          post.isLiked ? Icons.favorite : Icons.favorite_border,
          post.isLiked ? AppColors.like : AppColors.primary,
          () => controller.likePost(post.id),
        ),
        const SizedBox(width: AppSizes.largePadding),
        _buildActionButton(Icons.chat_bubble_outline, AppColors.primary, () {}),
        const SizedBox(width: AppSizes.largePadding),
        _buildActionButton(
          Icons.repeat,
          post.isReposted ? AppColors.repost : AppColors.primary,
          () => controller.repost(post.id),
        ),
        const SizedBox(width: AppSizes.largePadding),
        _buildActionButton(Icons.send_outlined, AppColors.primary, () {}),
      ],
    );
  }

  Widget _buildActionButton(
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(icon, color: color, size: 22),
    );
  }

  Widget _buildFooter() {
    return DefaultTextStyle(
      style: AppTextStyles.caption,
      child: Row(
        children: [
          if (post.repliesCount > 0)
            Text('${Formatters.formatNumber(post.repliesCount)} replies'),
          if (post.repliesCount > 0 && post.likesCount > 0) const Text(' · '),
          if (post.likesCount > 0)
            Text('${Formatters.formatNumber(post.likesCount)} likes'),
        ],
      ),
    );
  }
}

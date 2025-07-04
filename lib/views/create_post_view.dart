import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../controllers/feed_controller.dart';
import '../utils/constants.dart';

class CreatePostView extends GetView<FeedController> {
  final TextEditingController _contentController = TextEditingController();
  final Rx<File?> _selectedImage = Rx<File?>(null);
  final RxBool _isPosting = false.obs;

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
      leading: IconButton(
        icon: Icon(Icons.close, color: Theme.of(context).primaryColor),
        onPressed: () => Get.back(),
      ),
      title: Text('new_post'.tr, style: TextStyle(
        color: Theme.of(context).textTheme.titleLarge?.color,
      )),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: _isPosting.value ? null : () => _createPost(context),
          child: Text(
            'post'.tr,
            style: TextStyle(
              color: _isPosting.value 
                ? Theme.of(context).disabledColor 
                : Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.padding),
      child: Column(
        children: [
          _buildUserInfo(context),
          const SizedBox(height: AppSizes.padding),
          _buildContentField(context),
          const SizedBox(height: AppSizes.padding),
          Obx(() => _selectedImage.value != null ? _buildSelectedImage(context) : SizedBox.shrink()),
          Spacer(),
          _buildImagePicker(context),
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: AppSizes.avatarSize / 2,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.person, color: Colors.white),
        ),
        const SizedBox(width: AppSizes.padding),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'John Doe',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleMedium?.color,
              ),
            ),
            Text(
              '@johndoe',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContentField(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: _contentController,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          hintText: 'whats_on_your_mind'.tr,
          hintStyle: TextStyle(
            color: Theme.of(context).hintColor,
          ),
          border: InputBorder.none,
        ),
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
    );
  }

  Widget _buildSelectedImage(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).primaryColor),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              _selectedImage.value!,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                _selectedImage.value = null;
              },
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.image_outlined, color: Theme.of(context).primaryColor),
          onPressed: _pickImage,
        ),
        IconButton(
          icon: Icon(Icons.camera_alt_outlined, color: Theme.of(context).primaryColor),
          onPressed: () {
            // Handle camera
          },
        ),
        IconButton(
          icon: Icon(Icons.location_on_outlined, color: Theme.of(context).primaryColor),
          onPressed: () {
            // Handle location
          },
        ),
        const Spacer(),
        if (_isPosting.value)
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _selectedImage.value = File(image.path);
    }
  }

  Future<void> _createPost(BuildContext context) async {
    if (_contentController.text.trim().isEmpty) {
      Get.snackbar(
        'error'.tr,
        'post_content_required'.tr,
        backgroundColor: Theme.of(context).colorScheme.error,
        colorText: Colors.white,
      );
      return;
    }

    _isPosting.value = true;

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));

      // Add post to feed
      await controller.createPost(
        content: _contentController.text.trim(),
        imagePath: _selectedImage.value?.path,
      );

      Get.back();
      Get.snackbar(
        'success'.tr,
        'post_created'.tr,
        backgroundColor: Theme.of(context).primaryColor,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failed_create_post'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isPosting.value = false;
    }
  }
}

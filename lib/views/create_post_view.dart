import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../controllers/feed_controller.dart';
import '../utils/constants.dart';

class CreatePostView extends StatefulWidget {
  @override
  _CreatePostViewState createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final TextEditingController _contentController = TextEditingController();
  final FeedController _feedController = Get.find<FeedController>();
  File? _selectedImage;
  bool _isPosting = false;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

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
      leading: IconButton(
        icon: Icon(Icons.close, color: AppColors.primary),
        onPressed: () => Get.back(),
      ),
      title: Text('New thread', style: AppTextStyles.heading),
      actions: [
        TextButton(
          onPressed: _isPosting ? null : _createPost,
          child:
              _isPosting
                  ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  )
                  : Text(
                    'Post',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(AppSizes.padding),
      child: Column(
        children: [
          _buildUserInfo(),
          SizedBox(height: 16),
          _buildContentField(),
          SizedBox(height: 16),
          if (_selectedImage != null) _buildSelectedImage(),
          Spacer(),
          _buildImagePicker(),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.person, color: Colors.white),
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            Text(
              '@username',
              style: TextStyle(color: AppColors.secondary, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContentField() {
    return TextField(
      controller: _contentController,
      maxLines: 8,
      maxLength: 500,
      decoration: InputDecoration(
        hintText: 'Start a thread...',
        hintStyle: TextStyle(color: AppColors.secondary),
        border: InputBorder.none,
        counterStyle: TextStyle(color: AppColors.secondary),
      ),
      style: TextStyle(fontSize: 16, color: AppColors.text),
    );
  }

  Widget _buildSelectedImage() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              _selectedImage!,
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
                setState(() {
                  _selectedImage = null;
                });
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

  Widget _buildImagePicker() {
    return Row(
      children: [
        IconButton(
          onPressed: _pickImage,
          icon: Icon(Icons.image, color: AppColors.primary),
        ),
        Text(
          'Add photo',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _createPost() async {
    if (_contentController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter some content',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    setState(() {
      _isPosting = true;
    });

    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));

      // Add post to feed
      await _feedController.createPost(
        content: _contentController.text.trim(),
        imagePath: _selectedImage?.path,
      );

      Get.back();
      Get.snackbar(
        'Success',
        'Post created successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create post',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        _isPosting = false;
      });
    }
  }
}

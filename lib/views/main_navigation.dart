import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../utils/constants.dart';
import 'feed_view.dart';
import 'profile_view.dart';
import 'create_post_view.dart';

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  final AuthController authController = Get.find<AuthController>();
  int _currentIndex = 0;

  final List<Widget> _screens = [
    FeedView(),
    _buildSearchViewPlaceholder(),
    _buildActivityViewPlaceholder(),
    ProfileView(),
  ];

  void _onTap(int index) {
    if (index == 2) {
      Get.to(() => CreatePostView(), transition: Transition.downToUp);
      return;
    }
    setState(() {
      _currentIndex = index > 2 ? index - 1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  static Widget _buildSearchViewPlaceholder() {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Search', style: AppTextStyles.heading),
      ),
      body: Center(
        child: Text(
          'Search functionality coming soon',
          style: AppTextStyles.body,
        ),
      ),
    );
  }

  static Widget _buildActivityViewPlaceholder() {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('Activity', style: AppTextStyles.heading),
      ),
      body: Center(
        child: Text('Activity feed coming soon', style: AppTextStyles.body),
      ),
    );
  }

  Widget _buildProfileView() {
    return ProfileView();
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.secondary,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _currentIndex < 2 ? _currentIndex : _currentIndex + 1,
      onTap: _onTap,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: '',
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/create_post.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.secondary,
              BlendMode.srcIn,
            ),
          ),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_outlined),
          activeIcon: Icon(Icons.favorite),
          label: '',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: '',
        ),
      ],
    );
  }
}

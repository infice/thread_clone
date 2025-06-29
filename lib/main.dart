import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/auth_controller.dart';
import 'controllers/feed_controller.dart';
import 'views/main_navigation.dart';
import 'views/auth/login_view.dart';
import 'utils/constants.dart';

void main() {
  runApp(ThreadsCloneApp());
}

class ThreadsCloneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Threads Clone',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.primary),
          titleTextStyle: AppTextStyles.heading,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.background,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.secondary,
        ),
      ),
      home: SplashScreen(),
      getPages: [
        GetPage(name: '/login', page: () => LoginView()),
        GetPage(name: '/main', page: () => MainNavigation()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.background, AppColors.surface],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(60),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    const IconData(0xe35e, fontFamily: 'MaterialIcons'),
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 32),
              // App Name
              Text(
                'Threads',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w300,
                  color: AppColors.primary,
                  letterSpacing: -1.0,
                ),
              ),
              SizedBox(height: 16),
              // Tagline
              Text(
                'Instagram\'s text-based conversation app',
                style: AppTextStyles.caption,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 64),
              // Loading indicator
              Obx(() {
                if (authController.isLoading.value) {
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  );
                }
                return SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _initializeApp() {
    // Simulate app initialization
    Future.delayed(Duration(seconds: 2), () {
      if (authController.isLoggedIn) {
        Get.offAll(() => MainNavigation());
      } else {
        Get.offAll(() => LoginView());
      }
    });
  }
}

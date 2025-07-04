import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/feed_view.dart';
import 'views/auth/login_view.dart';
import 'views/auth/signup_view.dart';
import 'views/profile_view.dart';
import 'views/create_post_view.dart';
import 'views/main_navigation.dart';
import 'views/settings_view.dart';
import 'bindings/feed_binding.dart';
import 'bindings/auth_binding.dart';
import 'bindings/settings_binding.dart';
import 'translations/app_translations.dart';
import 'theme/app_theme.dart';
import 'services/theme_service.dart';
import 'services/localization_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize services
  await Get.putAsync(() => ThemeService().init());
  await Get.putAsync(() => LocalizationService().init());
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();
    final localizationService = Get.find<LocalizationService>();
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      initialBinding: AuthBinding(),
      translations: AppTranslations(),
      locale: localizationService.locale,
      fallbackLocale: const Locale('en', 'US'),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeService.themeMode,
      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginView(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/signup',
          page: () => SignupView(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/main',
          page: () => MainNavigation(),
          bindings: [AuthBinding(), FeedBinding()],
        ),
        GetPage(
          name: '/feed',
          page: () => FeedView(),
          binding: FeedBinding(),
        ),
        GetPage(
          name: '/profile',
          page: () => ProfileView(),
          bindings: [AuthBinding(), FeedBinding()],
        ),
        GetPage(
          name: '/create_post',
          page: () => CreatePostView(),
          binding: FeedBinding(),
        ),
        GetPage(
          name: '/settings',
          page: () => SettingsView(),
          binding: SettingsBinding(),
        ),
      ],
    );
  }
}

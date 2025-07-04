import 'package:get/get.dart';
import '../controllers/settings_controller.dart';
import '../services/localization_service.dart';
import '../services/theme_service.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ILocalizationService>(() => LocalizationService());
    Get.lazyPut<IThemeService>(() => ThemeService());
    Get.lazyPut<SettingsController>(() => SettingsController(
      Get.find<ILocalizationService>(),
      Get.find<IThemeService>(),
    ));
  }
} 
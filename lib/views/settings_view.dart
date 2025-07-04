import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';
import '../utils/constants.dart';

class SettingsView extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await controller.applyThemeSetting();
        await controller.applyLanguageSetting();
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
            onPressed: () async {
              await controller.applyThemeSetting();
              await controller.applyLanguageSetting();
              Get.back();
            },
          ),
          title: Text('settings'.tr, style: Theme.of(context).appBarTheme.titleTextStyle),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLanguageSection(context),
              SizedBox(height: 24),
              _buildThemeSection(context),
              SizedBox(height: 24),
              _buildOtherSettings(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'language'.tr,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Obx(() => Column(
            children: controller.getSupportedLanguages().map((language) {
              final isSelected = language['code'] == controller.pendingLanguage.value;
              return ListTile(
                leading: Icon(
                  Icons.language,
                  color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).iconTheme.color,
                ),
                title: Text(
                  language['nativeName'] ?? language['name'] ?? '',
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                subtitle: Text(
                  language['name'] ?? '',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                    fontSize: 12,
                  ),
                ),
                trailing: isSelected
                    ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                    : null,
                onTap: () {
                  controller.setPendingLanguage(language['code']!);
                },
              );
            }).toList(),
          )),
        ),
      ],
    );
  }

  Widget _buildThemeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'theme'.tr,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Obx(() => Column(
            children: [
              RadioListTile<ThemeMode>(
                value: ThemeMode.light,
                groupValue: controller.pendingThemeMode.value,
                onChanged: (mode) {
                  if (mode != null) {
                    controller.setPendingThemeMode(mode);
                    controller.applyThemeSetting();
                  }
                },
                title: Text('light_mode'.tr),
                secondary: Icon(Icons.light_mode, color: Theme.of(context).iconTheme.color),
              ),
              RadioListTile<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: controller.pendingThemeMode.value,
                onChanged: (mode) {
                  if (mode != null) {
                    controller.setPendingThemeMode(mode);
                    controller.applyThemeSetting();
                  }
                },
                title: Text('dark_mode'.tr),
                secondary: Icon(Icons.dark_mode, color: Theme.of(context).iconTheme.color),
              ),
            ],
          )),
        ),
      ],
    );
  }

  Widget _buildOtherSettings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Other Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Column(
            children: [
              _buildSettingTile(
                context,
                icon: Icons.notifications_outlined,
                title: 'notifications'.tr,
                onTap: () {
                  // TODO: Implement notifications settings
                },
              ),
              _buildDivider(context),
              _buildSettingTile(
                context,
                icon: Icons.privacy_tip_outlined,
                title: 'privacy'.tr,
                onTap: () {
                  // TODO: Implement privacy settings
                },
              ),
              _buildDivider(context),
              _buildSettingTile(
                context,
                icon: Icons.security_outlined,
                title: 'security'.tr,
                onTap: () {
                  // TODO: Implement security settings
                },
              ),
              _buildDivider(context),
              _buildSettingTile(
                context,
                icon: Icons.info_outline,
                title: 'about'.tr,
                onTap: () {
                  // TODO: Implement about page
                },
              ),
              _buildDivider(context),
              _buildSettingTile(
                context,
                icon: Icons.help_outline,
                title: 'help'.tr,
                onTap: () {
                  // TODO: Implement help page
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
      ),
      trailing: Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
      onTap: onTap,
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      color: Theme.of(context).dividerColor,
      indent: 56,
    );
  }
} 
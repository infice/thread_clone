import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/mock_data_service.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final IAuthService authService;
  AuthController(this.authService);

  final Rx<User?> currentUser = Rx<User?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxInt currentIndex = 0.obs;

  // TextEditingControllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool get isLoggedIn => currentUser.value != null;

  @override
  void onInit() {
    super.onInit();
    // Initialize with a default user for demo
    currentUser.value = User(
      id: 'current_user',
      username: 'user',
      displayName: 'User Name',
      profileImage: null,
      isVerified: false,
    );
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  Future<bool> login() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('error'.tr, 'invalid_credentials'.tr);
      return false;
    }
    
    isLoading.value = true;
    final success = await authService.loginWithCredentials(
      usernameController.text.trim(),
      passwordController.text.trim(),
    );
    isLoading.value = false;
    
    if (success) {
      Get.offAllNamed('/main');
    } else {
      Get.snackbar('error'.tr, 'invalid_credentials'.tr);
    }
    
    return success;
  }

  Future<bool> signup() async {
    if (nameController.text.isEmpty || 
        emailController.text.isEmpty || 
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar('error'.tr, 'fill_fields_correctly'.tr);
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('error'.tr, 'passwords_dont_match'.tr);
      return false;
    }
    
    isLoading.value = true;
    final success = await authService.signup(
      nameController.text.trim(),
      emailController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    isLoading.value = false;
    
    if (success) {
      Get.offAllNamed('/main');
    } else {
      Get.snackbar('error'.tr, 'fill_fields_correctly'.tr);
    }
    
    return success;
  }

  Future<bool> loginWithCredentials(String username, String password) async {
    isLoading.value = true;
    final success = await authService.loginWithCredentials(username, password);
    isLoading.value = false;
    return success;
  }

  Future<void> logout() async {
    await authService.logout();
    currentUser.value = null;
    Get.offAllNamed('/login');
  }
}

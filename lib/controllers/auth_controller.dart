import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/mock_data_service.dart';

class AuthController extends GetxController {
  final Rx<User?> currentUser = Rx<User?>(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Don't auto-login, let user authenticate manually
  }

  Future<bool> loginWithCredentials(String username, String password) async {
    isLoading.value = true;
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    
    // Mock authentication
    if (username == 'user' && password == '123456') {
      currentUser.value = MockDataService.getCurrentUser();
      isLoading.value = false;
      return true;
    }
    
    isLoading.value = false;
    return false;
  }

  Future<bool> signup(String fullName, String username, String email, String password) async {
    isLoading.value = true;
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    
    // For demo purposes, accept any valid signup data
    if (fullName.isNotEmpty && username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      // Create a new user with the provided data
      currentUser.value = User(
        id: 'new_user_${DateTime.now().millisecondsSinceEpoch}',
        username: username,
        displayName: fullName,
        profileImage: null,
        bio: 'New Threads user',
        followersCount: 0,
        followingCount: 0,
        isVerified: false,
        isFollowing: false,
      );
      isLoading.value = false;
      return true;
    }
    
    isLoading.value = false;
    return false;
  }

  void logout() {
    currentUser.value = null;
    Get.offAllNamed('/login');
  }

  bool get isLoggedIn => currentUser.value != null;
}

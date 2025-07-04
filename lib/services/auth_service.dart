abstract class IAuthService {
  Future<bool> loginWithCredentials(String username, String password);
  Future<bool> signup(String fullName, String username, String email, String password);
  Future<void> logout();
}

class MockAuthService implements IAuthService {
  @override
  Future<bool> loginWithCredentials(String username, String password) async {
    // mock logic
    return username == 'user' && password == '123456';
  }

  @override
  Future<bool> signup(String fullName, String username, String email, String password) async {
    // mock logic
    return true;
  }

  @override
  Future<void> logout() async {
    // mock logic
  }
} 
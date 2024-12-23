import 'auth_service.dart';

class LogoutService extends AuthService {
  Future<void> logout(String token) async {
    await post('logout', {}).then((response) {
      if (response.statusCode != 200) {
        throw Exception('Logout failed: ${response.body}');
      }
    });
  }
}

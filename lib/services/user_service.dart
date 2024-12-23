import 'package:dio/dio.dart';

class UserService {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://10.0.2.2:8000/api';

  //edit user
  Future<Response> editUser(String token, Map<String, dynamic> body) async {
    try {
      final response = await _dio.put(
        '$_baseUrl/user',
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to edit user: $e');
    }
  }
}

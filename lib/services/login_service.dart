import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  final String baseUrl =
      'http://10.0.2.2:8000/api'; // Define your base URL here

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await post('login', {
      'email': email,
      'password': password,
    });

    print('URL: ${Uri.parse("$baseUrl/login")}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  Future<http.Response> post(String endpoint, Map<String, String> body) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return await http.post(url, body: body);
  }
}

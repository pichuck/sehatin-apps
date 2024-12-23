import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterService {
  final String baseUrl = "http://10.0.2.2:8000/api"; // Gunakan base URL Anda

  Future<Map<String, dynamic>> register(Map<String, String> userData) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(url, body: userData);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Register failed: ${response.body}');
    }
  }
}

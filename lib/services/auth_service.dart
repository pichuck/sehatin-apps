import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl =
      "http://10.0.2.2:8000/api"; // Ganti dengan URL API Anda

  Future<http.Response> post(String endpoint, Map<String, String> body) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return await http.post(url, body: body);
  }

  Future<http.Response> get(String endpoint, {String? token}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    print('Token: $token'); // Log token
    return await http.get(url, headers: {
      if (token != null) 'Authorization': 'Bearer $token',
    });
  }

  Future<http.Response> updateAccountDetails(
      String token, Map<String, String> body) async {
    final url = Uri.parse('$baseUrl/update-account');
    return await http.put(url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body));
  }

  Future<http.Response> updateProfilePicture(
      String token, String filePath) async {
    final url = Uri.parse('$baseUrl/update-profile-picture');
    var request = http.MultipartRequest('PUT', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath('picture', filePath));
    var response = await request.send();
    return await http.Response.fromStream(response);
  }

  Future<http.Response> getProfilePicture(String token) async {
    final url = Uri.parse('$baseUrl/profile-picture');
    return await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
  }

  static Future<http.Response> getUserData(String token) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/user'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }
}

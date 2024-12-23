import 'package:dio/dio.dart';

class ArtikelService {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://10.0.2.2:8000/api';

  // Mendapatkan semua artikel
  Future<List<dynamic>> fetchArtikels() async {
    try {
      final response =
          await _dio.get('$_baseUrl/artikel'); // Endpoint untuk semua artikel
      if (response.statusCode == 200) {
        return response.data['data']; // Ambil daftar artikel dari 'data'
      } else {
        throw Exception('Failed to load artikels');
      }
    } catch (e) {
      throw Exception('Failed to load artikels: $e');
    }
  }

  // Mendapatkan artikel berdasarkan kategori
  Future<List<dynamic>> fetchArtikelsByCategory(String category) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/artikel', // Endpoint tetap menggunakan `/artikel`
        queryParameters: {
          'category': category
        }, // Query parameter untuk kategori
      );
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception('Failed to load artikels by category');
      }
    } catch (e) {
      throw Exception('Failed to load artikels by category: $e');
    }
  }
}

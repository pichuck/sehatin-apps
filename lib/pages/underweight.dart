import 'package:flutter/material.dart';
import 'package:sehatin/services/artikel_service.dart';
import 'package:sehatin/services/resep_service.dart';
import 'package:sehatin/pages/detailArticle.dart';
import 'package:sehatin/pages/detailResep.dart';

class UnderweightScreen extends StatefulWidget {
  const UnderweightScreen({super.key});

  @override
  _UnderweightScreenState createState() => _UnderweightScreenState();
}

class _UnderweightScreenState extends State<UnderweightScreen> {
  late Future<List<dynamic>> _artikels;
  late Future<List<dynamic>> _reseps;

  @override
  void initState() {
    super.initState();
    _artikels = ArtikelService().fetchArtikelsByCategory('underweight');
    _reseps = ResepService().fetchResepByCategory('underweight');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1D4533),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Bagian Atas: Lengkungan Custom
          Stack(
            alignment: Alignment.center,
            children: [
              ClipPath(
                clipper: HeaderClipper(),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF1D4533),
                        Color(0xFF2E5746),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 45,
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFFC1CE71),
                    child: const Text(
                      '6.9',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E5746),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Hasil Perhitungan BMI Anda',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Berat Badan Kurang Ideal',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E5746),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Artikel Terkait
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _artikels,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No articles found.'));
                } else {
                  return ListView(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Artikel Terkait:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...snapshot.data!.map((artikel) {
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ArticleDetailPage(
                                    judul: artikel['judul'] ?? 'No Title',
                                    isi: artikel['isi'] ?? 'No Content',
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    artikel['judul'] ?? 'No Title',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    artikel['isi']?.substring(0, 50) ??
                                        '' + '...',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  );
                }
              },
            ),
          ),

          // Resep Terkait
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _reseps,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No recipes found.'));
                } else {
                  return ListView(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Resep Terkait:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...snapshot.data!.map((resep) {
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipeDetailPage(
                                    judul: resep['judul'] ?? 'No Title',
                                    isi: resep['isi'] ?? 'No Content',
                                    foto: resep['foto'] ?? '',
                                    category: resep['category'] ?? 'Unknown',
                                    chef: resep['user']?['name'] ?? 'Unknown',
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    resep['judul'] ?? 'No Title',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    resep['isi']?.substring(0, 50) ??
                                        '' + '...',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Clipper untuk membentuk lengkungan seperti gambar
class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
      size.width / 2, size.height, // Titik kontrol dan akhir
      size.width, size.height - 80,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

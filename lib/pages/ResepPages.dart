import 'package:flutter/material.dart';
import 'package:sehatin/services/resep_service.dart';
import 'package:sehatin/pages/detailResep.dart';
import '../layout/bottom_navbar.dart';

class ResepPage extends StatelessWidget {
  final String token;
  final String userName;

  const ResepPage({super.key, required this.token, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resep'),
        backgroundColor: const Color(0xFF1A4D2E),
        elevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: ResepService().fetchReseps(), // Panggil data resep dari API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No recipes found'));
          } else {
            final reseps = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: reseps.length,
              itemBuilder: (context, index) {
                final resep = reseps[index];
                return GestureDetector(
                  onTap: () {
                    // Navigasi ke detail resep
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailPage(
                          judul: resep['judul'] ??
                              'No Title', // Jika null, tampilkan default
                          isi: resep['isi'] ?? 'No Content',
                          foto: resep['foto'] ?? '',
                          category: resep['category'] ?? 'Unknown Category',
                          chef: resep['user']?['name'] ??
                              'Unknown Chef', // Handle nested null
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFEFEF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Tampilkan gambar resep
                        if (resep['foto'] != null)
                          Image.network(
                            resep['foto'],
                            height: 80,
                            fit: BoxFit.cover,
                          )
                        else
                          const Icon(
                            Icons.fastfood,
                            size: 80,
                            color: Colors.grey,
                          ),
                        const SizedBox(height: 8),
                        // Judul resep
                        Text(
                          resep['judul'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        // Kategori resep
                        Text(
                          resep['category'] ?? 'Unknown Category',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        token: token,
        userName: userName,
        onTap: (index) {},
      ),
    );
  }
}

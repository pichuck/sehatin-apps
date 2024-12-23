import 'package:flutter/material.dart';
import 'package:sehatin/services/artikel_service.dart';
import 'package:sehatin/pages/detailArticle.dart';
import '../layout/bottom_navbar.dart';

class ArticlesPage extends StatelessWidget {
  final String token;
  final String userName;

  const ArticlesPage({required this.token, required this.userName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles'),
        backgroundColor: const Color(0xFF1A4D2E),
        elevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: ArtikelService().fetchArtikels(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No articles found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final artikel = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: artikel['foto'] != null
                        ? Image.network(artikel['foto'],
                            width: 50, height: 50, fit: BoxFit.cover)
                        : const Icon(Icons.article, size: 50),
                    title: Text(artikel['judul']),
                    subtitle: Text(
                      artikel['isi'].substring(0, 50) + '...',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleDetailPage(
                            judul: artikel['judul'],
                            isi: artikel['isi'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {},
        token: token,
        userName: userName,
      ),
    );
  }
}

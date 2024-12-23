import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  final String judul;
  final String isi;
  final String foto;
  final String category;
  final String chef;

  const RecipeDetailPage({
    super.key,
    required this.judul,
    required this.isi,
    required this.foto,
    required this.category,
    required this.chef,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul.isNotEmpty ? judul : 'No Title'), // Validasi judul
        backgroundColor: const Color(0xFF1A4D2E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar resep
              if (foto.isNotEmpty)
                Image.network(
                  foto,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                )
              else
                const Icon(
                  Icons.image_not_supported,
                  size: 100,
                  color: Colors.grey,
                ),
              const SizedBox(height: 20),
              // Judul resep
              Text(
                judul.isNotEmpty ? judul : 'No Title', // Validasi judul
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Kategori dan Chef
              Text(
                'Category: ${category.isNotEmpty ? category : 'Unknown'}\nChef: ${chef.isNotEmpty ? chef : 'Unknown'}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              // Isi resep
              Text(
                isi.isNotEmpty ? isi : 'No Content Available',
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

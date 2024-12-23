import 'package:flutter/material.dart';
import 'package:sehatin/layout/bottom_navbar.dart'; // Import BottomNavBar
import 'package:sehatin/services/resep_service.dart';
import 'package:sehatin/pages/detailResep.dart'; // Import ResepDetailPage

class HomePage extends StatefulWidget {
  final String token;
  final String userName;

  const HomePage({
    super.key,
    required this.token,
    required this.userName,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late Future<List<dynamic>> _reseps; // Future untuk menyimpan data resep

  @override
  void initState() {
    super.initState();
    _reseps = ResepService().fetchAllResep(); // Ambil data dari API
  }

  void _onNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              token: widget.token,
              userName: widget.userName,
            ),
          ),
        );
        break;
      case 1:
        // Navigate to another page
        break;
      case 2:
        // Navigate to BMI page
        break;
      case 3:
        // Navigate to article page
        break;
      case 4:
        // Navigate to profile page
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Halo, ${widget.userName}',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _reseps,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No recipes found.'));
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9F5EC),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari Resep Makanan di sini ...',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Recommended Recipes Section
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rekomendasi Resep Makanan Bergizi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Recipe Grid View
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final resep = snapshot.data![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeDetailPage(
                                  judul: resep['judul'] ??
                                      'No Title', // Jika null, tampilkan default
                                  isi: resep['isi'] ?? 'No Content',
                                  foto: resep['foto'] ?? '',
                                  category:
                                      resep['category'] ?? 'Unknown Category',
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Image Placeholder (use actual image if available)
                                if (resep['foto'] != null)
                                  Image.network(
                                    resep['foto'],
                                    height: 80,
                                    fit: BoxFit.cover,
                                  )
                                else
                                  Container(
                                    height: 80,
                                    color: Colors.grey.shade300,
                                    child: const Center(
                                      child: Icon(
                                        Icons.fastfood,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                // Recipe Title
                                Text(
                                  resep['judul'] ?? 'No Title',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Recipe Description
                                Text(
                                  resep['category'] ?? 'No Category',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTapped,
        token: widget.token,
        userName: widget.userName,
      ),
    );
  }
}

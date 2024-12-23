import 'package:flutter/material.dart';
import 'package:sehatin/layout/bottom_navbar.dart';
import 'package:sehatin/services/auth_service.dart';
import 'dart:convert';
import 'package:sehatin/pages/detailAkun.dart'; // Ensure this file exists at the specified path

// Model untuk data akun
class Akun {
  final String nama;
  final String email;
  final String noHp;
  final String imageUrl;

  Akun(
      {required this.nama,
      required this.email,
      required this.noHp,
      required this.imageUrl});
}

class ProfilePage extends StatefulWidget {
  final String token;
  final String userName;

  const ProfilePage({super.key, required this.token, required this.userName});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? email;
  String? noHp;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final response = await AuthService().get('user', token: widget.token);
      print(
          'Response Body: ${response.body}'); // Debugging untuk melihat respons
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['user'];
        setState(() {
          email = data['email'];
          noHp = data['no_hp'];
          imageUrl = data['foto']; // Ambil URL foto
        });
      } else {
        print('Failed to fetch user data: ${response.body}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = 4; // Indeks awal untuk halaman profil

    // Fungsi navigasi antar halaman
    void onNavTapped(int index) {
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/home');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/pesan');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/cek_bmi');
          break;
        case 3:
          Navigator.pushReplacementNamed(context, '/artikel');
          break;
        case 4:
          // Tetap di halaman Profil
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Full background gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF4F6F52), Color(0xFF1A4D2E)],
              ),
            ),
          ),
          // Main content
          Column(
            children: [
              // Profile section
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Profile photo
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              imageUrl != null ? NetworkImage(imageUrl!) : null,
                          child: imageUrl == null
                              ? Icon(Icons.person,
                                  size: 80, color: Colors.white)
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(6),
                              child: Icon(Icons.edit,
                                  color: Color(0xFF4F6F52), size: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // User name
                    Text(
                      widget.userName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Email
                    Text(
                      email ?? 'Email not available',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Phone number
                    Text(
                      noHp ?? 'Phone number not available',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Menu options
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildProfileOption(
                        icon: Icons.person_outline,
                        title: 'Akun Saya',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditUserPage(
                                token: widget.token,
                                userName: widget.userName,
                              ),
                            ),
                          );
                        },
                      ),
                      _buildProfileOption(
                        icon: Icons.exit_to_app,
                        title: 'Keluar',
                        onTap: () {},
                      ),
                      _buildProfileOption(
                        icon: Icons.help_outline,
                        title: 'Bantuan',
                        onTap: () {},
                      ),
                      _buildProfileOption(
                        icon: Icons.info_outline,
                        title: 'Tentang Aplikasi',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: onNavTapped,
        token: widget.token,
        userName: widget.userName,
      ),
    );
  }

  // Widget for profile option menu item
  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF4F6F52)),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}

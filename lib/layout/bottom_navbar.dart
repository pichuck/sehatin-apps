import 'package:flutter/material.dart';
import '../pages/calculator_bmi.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';
import '../pages/ArticlesPage.dart'; // Import the ArticlesPage
import '../pages/ResepPages.dart'; // Import the ResepPage

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final String token; // Tambahkan parameter token
  final String userName; // Tambahkan parameter userName

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.token, // Tambahkan token
    required this.userName, // Tambahkan userName
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0: // Navigasi ke Home
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  token: token, // Kirim token dinamis
                  userName: userName, // Kirim userName dinamis
                ),
              ),
            );
            break;
          case 1: // Navigasi ke Resep
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResepPage(
                  token: token, // Kirim token dinamis
                  userName: userName, // Kirim userName dinamis
                ), // Navigate to ResepPage
              ),
            );
            break;
          case 2: // Navigasi ke Cek BMI
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BMIScreen(
                  token: token, // Kirim token dinamis
                  userName: userName, // Kirim userName dinamis
                ),
              ),
            );
            break;
          case 3: // Navigasi ke Artikel
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ArticlesPage(
                  token: token, // Kirim token dinamis
                  userName: userName, // Kirim userName dinamis
                ),
              ),
            );
            break;
          case 4: // Navigasi ke Profil
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(
                      token: token, // Kirim token dinamis
                      userName: userName // Kirim userName dinamis
                      )),
            );
            break;
          default:
            onTap(index);
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF1A4D2E),
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant_menu),
          label: 'Resep',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calculate),
          label: 'Cek BMI',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article),
          label: 'Artikel',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }
}

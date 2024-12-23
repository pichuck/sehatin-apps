import 'package:flutter/material.dart';
import 'signin.dart'; // Import halaman Sign In

class LandingPages extends StatefulWidget {
  const LandingPages({super.key});

  @override
  State<LandingPages> createState() => _LandingPagesState();
}

class _LandingPagesState extends State<LandingPages> {
  @override
  void initState() {
    super.initState();

    // Delay 3 detik, lalu navigasi ke halaman Sign In
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double fontSize = MediaQuery.of(context).size.width * 0.08;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4F6F52), // Warna atas
              Color(0xFF1A4D2E), // Warna bawah
            ],
          ),
        ),
        child: Center(
          child: Text(
            'SehatIn',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFF5EFE6),
            ),
          ),
        ),
      ),
    );
  }
}

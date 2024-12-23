import 'package:flutter/material.dart';
import 'pages/landingPages.dart';
import 'pages/calculator_bmi.dart';
import 'pages/profile_page.dart';
import 'pages/ArticlesPage.dart'; // Import the ArticlesPage
import 'pages/ResepPages.dart'; // Import the ResepPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SehatIn',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        fontFamily: 'Montserrat',
      ),
      debugShowCheckedModeBanner: false,
      home: const LandingPages(), // Halaman awal adalah LandingPages
      routes: {
        '/cek_bmi': (context) => const BMIScreen(
            token: 'your_token',
            userName: 'your_userName'), // Rute untuk Cek BMI
        '/profile': (context) => const ProfilePage(
            token: 'your_token', userName: 'your_userName'), // Rute Profil
        '/articles': (context) => ArticlesPage(
            token: 'your_token',
            userName: 'your_userName'), // Add route for ArticlesPage
        '/resep': (context) => ResepPage(
            token: 'your_token',
            userName: 'your_userName'), // Add route for ResepPage
      },
    );
  }
}

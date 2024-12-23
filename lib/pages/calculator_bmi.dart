import 'package:flutter/material.dart';
import '../layout/bottom_navbar.dart';
import 'overweight.dart'; // Import halaman Overweight
import 'ideal.dart'; // Import halaman Ideal
import 'underweight.dart'; // Import halaman Underweight

class BMIScreen extends StatefulWidget {
  final String token;
  final String userName;

  const BMIScreen({super.key, required this.token, required this.userName});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final int _currentIndex = 2; // Indeks default "Cek BMI"

  int height = 170;
  int weight = 70;
  int age = 19;
  bool isMale = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator BMI'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildGenderSelector(),
            const SizedBox(height: 16),
            _buildHeightCard(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCounterCard('Berat Badan', weight, () {
                  setState(() => weight--);
                }, () {
                  setState(() => weight++);
                }),
                _buildCounterCard('Umur', age, () {
                  setState(() => age--);
                }, () {
                  setState(() => age++);
                }),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _calculateBMI(); // Panggil fungsi hitung BMI
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E5746),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Hitung BMI',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTapped,
        token: widget.token, // Kirim token dinamis
        userName: widget.userName, // Kirim userName dinamis
      ),
    );
  }

  // Fungsi menghitung BMI dan navigasi
  void _calculateBMI() {
    double bmi = weight / ((height / 100) * (height / 100));

    if (bmi < 18.5) {
      // BMI di bawah 18.5: Underweight
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UnderweightScreen()),
      );
    } else if (bmi >= 25) {
      // BMI di atas 25: Overweight
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OverweightScreen()),
      );
    } else {
      // BMI antara 18.5 dan 24.9: Ideal
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const IdealScreen()),
      );
    }
  }

  // Gender Selector
  Widget _buildGenderSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _genderCard('Laki-laki', Icons.male, isMale, true),
        _genderCard('Perempuan', Icons.female, !isMale, false),
      ],
    );
  }

  Widget _genderCard(
      String label, IconData icon, bool isSelected, bool isMaleSelected) {
    return GestureDetector(
      onTap: () => setState(() => isMale = isMaleSelected),
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width * 0.43,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2E5746) : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 28, color: isSelected ? Colors.white : Colors.black54),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tinggi Badan
  Widget _buildHeightCard() {
    return Container(
      height: 160,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Tinggi Badan', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          Text(
            '$height cm',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Slider(
            value: height.toDouble(),
            min: 100,
            max: 220,
            activeColor: const Color(0xFF2E5746),
            onChanged: (value) => setState(() => height = value.round()),
          ),
        ],
      ),
    );
  }

  // Counter Card untuk Berat Badan dan Umur
  Widget _buildCounterCard(
      String label, int value, VoidCallback onMinus, VoidCallback onPlus) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          Text('$value',
              style:
                  const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _counterButton(Icons.remove, onMinus),
              _counterButton(Icons.add, onPlus),
            ],
          ),
        ],
      ),
    );
  }

  Widget _counterButton(IconData icon, VoidCallback onTap) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, color: const Color(0xFF2E5746)),
    );
  }

  void _onNavTapped(int index) {
    if (index == 2) return; // Hindari reload halaman yang sama
    Navigator.pop(context);
  }
}

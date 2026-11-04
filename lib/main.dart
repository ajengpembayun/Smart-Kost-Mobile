
import 'package:flutter/material.dart';
import 'data/complaint_data.dart';
import 'screens/role_selection_screen.dart';

void main() {
  // Membuat penyimpanan data komplain satu kali
  final complaintData = ComplaintData();

  runApp(
    SmartKostApp(complaintData: complaintData),
  );
}

class SmartKostApp extends StatelessWidget {
  final ComplaintData complaintData;

  const SmartKostApp({
    super.key,
    required this.complaintData,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Kost',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,

        // Warna utama aplikasi
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0B1F4D),
          primary: const Color(0xFF0B1F4D),
          secondary: const Color(0xFF1D4ED8),
          surface: Colors.white,
        ),

        // Background halaman
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),

        // AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF0B1F4D),
          elevation: 0,
          centerTitle: false,
        ),

        // Tampilan Card
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        // Tampilan tombol utama
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0B1F4D),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),

      home: RoleSelectionScreen(
        complaintData: complaintData,
      ),
    );
  }
}

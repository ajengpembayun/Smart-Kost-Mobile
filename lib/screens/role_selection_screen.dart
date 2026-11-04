
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/complaint_data.dart';
import 'dashboard_screen.dart';
import 'owner/owner_dashboard_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  final ComplaintData complaintData;

  const RoleSelectionScreen({
    super.key,
    required this.complaintData,
  });

  static const Color navy = Color(0xFF0B1F4D);
  static const Color blue = Color(0xFF1D4ED8);
  static const Color muted = Color(0xFF64748B);

  void _openTenant(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardScreen(
          complaintData: complaintData,
        ),
      ),
    );
  }

  void _openOwner(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OwnerDashboardScreen(
          complaintData: complaintData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 35),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: navy,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.apartment_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Smart Kost',
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: navy,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Kelola hunian kos dengan lebih mudah, '
                    'praktis, dan terorganisir.',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: muted,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 38),
                  Text(
                    'Pilih Peran Anda',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: navy,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'Silakan pilih tampilan sesuai peran Anda.',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: muted,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Pilihan Tenant
                  _roleCard(
                    icon: Icons.person_rounded,
                    title: 'Tenant',
                    description:
                        'Akses informasi kamar dan buat laporan komplain.',
                    buttonText: 'Masuk sebagai Tenant',
                    onTap: () => _openTenant(context),
                  ),

                  const SizedBox(height: 15),

                  // Pilihan Owner
                  _roleCard(
                    icon: Icons.admin_panel_settings_rounded,
                    title: 'Owner / Pengelola',
                    description:
                        'Pantau laporan dan kelola komplain penghuni.',
                    buttonText: 'Masuk sebagai Owner',
                    onTap: () => _openOwner(context),
                  ),

                  const SizedBox(height: 30),
                  Center(
                    child: Text(
                      'Smart Kost Mobile • Demo G1',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: muted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _roleCard({
    required IconData icon,
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE8EDF5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: navy, size: 25),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: navy,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: muted,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 17),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: navy,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                buttonText,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

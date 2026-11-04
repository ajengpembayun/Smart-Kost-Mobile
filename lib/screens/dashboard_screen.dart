
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/complaint_data.dart';
import 'complaint_form_screen.dart';
import 'complaint_history_screen.dart';

class DashboardScreen extends StatefulWidget {
  final ComplaintData complaintData;

  const DashboardScreen({
    super.key,
    required this.complaintData,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static const Color navy = Color(0xFF0B1F4D);
  static const Color blue = Color(0xFF1D4ED8);
  static const Color background = Color(0xFFF5F7FC);
  static const Color muted = Color(0xFF64748B);

  void _openComplaintForm() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ComplaintFormScreen(
          complaintData: widget.complaintData,
        ),
      ),
    );

    if (mounted) {
      setState(() {});
    }
  }

  void _openComplaintHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ComplaintHistoryScreen(
          complaintData: widget.complaintData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final complaintCount =
        widget.complaintData.complaints.length;

    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 22,
        title: Row(
          children: [
            const Icon(
              Icons.apartment_rounded,
              color: navy,
              size: 27,
            ),
            const SizedBox(width: 9),
            Text(
              'Smart Kost',
              style: GoogleFonts.inter(
                color: navy,
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: navy,
              size: 25,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 26, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            Text(
              'Halo, Penghuni! 👋',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: navy,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Selamat datang kembali di Smart Kost.',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: muted,
              ),
            ),

            const SizedBox(height: 26),

            // Informasi Hunian
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF0B1F4D),
                    Color(0xFF173B78),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: navy.withValues(alpha: 0.16),
                    blurRadius: 20,
                    offset: const Offset(0, 9),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.home_work_outlined,
                        color: Colors.white70,
                        size: 17,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'INFORMASI HUNIAN',
                        style: GoogleFonts.inter(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Kamar A-03',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        color: Color(0xFF86EFAC),
                        size: 17,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Status Hunian Aktif',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Ringkasan
            _buildSectionTitle('Ringkasan'),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    icon: Icons.receipt_long_rounded,
                    title: 'Tagihan',
                    value: '1',
                    subtitle: 'Tagihan aktif',
                    iconColor: const Color(0xFFD69A35),
                  ),
                ),

                const SizedBox(width: 13),

                Expanded(
                  child: _buildSummaryCard(
                    icon: Icons.report_gmailerrorred_rounded,
                    title: 'Komplain',
                    value: complaintCount.toString(),
                    subtitle: 'Total laporan',
                    iconColor: blue,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Layanan
            _buildSectionTitle('Layanan Penghuni'),

            const SizedBox(height: 7),

            Text(
              'Akses layanan kos dengan mudah.',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: muted,
              ),
            ),

            const SizedBox(height: 15),

            _buildMenuCard(
              icon: Icons.add_comment_rounded,
              title: 'Buat Komplain',
              description: 'Laporkan masalah fasilitas kos.',
              onTap: _openComplaintForm,
            ),

            const SizedBox(height: 13),

            _buildMenuCard(
              icon: Icons.history_rounded,
              title: 'Riwayat Komplain',
              description: 'Pantau laporan komplain Anda.',
              onTap: _openComplaintHistory,
            ),

            const SizedBox(height: 25),

            // Footer
            Center(
              child: Text(
                'SMART KOST • HUNIAN LEBIH TERATUR',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w800,
        color: navy,
      ),
    );
  }

  Widget _buildSummaryCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color iconColor,
  }) {
    return Container(
      constraints: const BoxConstraints(minHeight: 145),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFE8EDF5),
        ),
        boxShadow: [
          BoxShadow(
            color: navy.withValues(alpha: 0.035),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 21,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: navy,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF475569),
            ),
          ),

          const SizedBox(height: 3),

          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: muted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 17,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFE8EDF5),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: navy,
                  size: 22,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: navy,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      description,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: muted,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFF94A3B8),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

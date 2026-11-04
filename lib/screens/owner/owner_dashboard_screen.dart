
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/complaint_data.dart';
import 'owner_complaint_list_screen.dart';

class OwnerDashboardScreen extends StatefulWidget {
  final ComplaintData complaintData;

  const OwnerDashboardScreen({
    super.key,
    required this.complaintData,
  });

  @override
  State<OwnerDashboardScreen> createState() =>
      _OwnerDashboardScreenState();
}

class _OwnerDashboardScreenState
    extends State<OwnerDashboardScreen> {
  static const Color navy = Color(0xFF0B1F4D);
  static const Color muted = Color(0xFF64748B);

  Future<void> _openComplaintList() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OwnerComplaintListScreen(
          complaintData: widget.complaintData,
        ),
      ),
    );

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final complaintData = widget.complaintData;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.apartment_rounded, color: navy),
            const SizedBox(width: 9),
            Text(
              'Smart Kost',
              style: GoogleFonts.inter(
                color: navy,
                fontWeight: FontWeight.w800,
                fontSize: 19,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard Pengelola',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: navy,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              'Pantau dan kelola laporan penghuni kos.',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: muted,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'Ringkasan Komplain',
              style: GoogleFonts.inter(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: navy,
              ),
            ),
            const SizedBox(height: 15),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 13,
              mainAxisSpacing: 13,
              childAspectRatio: 1.35,
              children: [
                _summaryCard(
                  icon: Icons.inbox_rounded,
                  title: 'Total Komplain',
                  value: complaintData.totalComplaints,
                  color: navy,
                ),
                _summaryCard(
                  icon: Icons.schedule_rounded,
                  title: 'Menunggu',
                  value: complaintData.waitingCount,
                  color: const Color(0xFFD97706),
                ),
                _summaryCard(
                  icon: Icons.autorenew_rounded,
                  title: 'Diproses',
                  value: complaintData.processingCount,
                  color: const Color(0xFF2563EB),
                ),
                _summaryCard(
                  icon: Icons.check_circle_rounded,
                  title: 'Selesai',
                  value: complaintData.completedCount,
                  color: const Color(0xFF15803D),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'Pengelolaan',
              style: GoogleFonts.inter(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: navy,
              ),
            ),
            const SizedBox(height: 14),
            InkWell(
              onTap: _openComplaintList,
              borderRadius: BorderRadius.circular(18),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                      child: const Icon(
                        Icons.report_gmailerrorred_rounded,
                        color: navy,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kelola Komplain',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: navy,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Periksa dan tangani laporan penghuni.',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: muted,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard({
    required IconData icon,
    required String title,
    required int value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE8EDF5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 9),
          Text(
            value.toString(),
            style: GoogleFonts.inter(
              fontSize: 23,
              fontWeight: FontWeight.w800,
              color: navy,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: muted,
            ),
          ),
        ],
      ),
    );
  }
}

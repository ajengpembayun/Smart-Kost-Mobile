
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/complaint_data.dart';

class ComplaintHistoryScreen extends StatelessWidget {
  final ComplaintData complaintData;

  const ComplaintHistoryScreen({
    super.key,
    required this.complaintData,
  });

  static const Color navy = Color(0xFF0B1F4D);
  static const Color muted = Color(0xFF64748B);

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Menunggu':
        return const Color(0xFFD97706);
      case 'Diproses':
        return const Color(0xFF2563EB);
      case 'Selesai':
        return const Color(0xFF15803D);
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Menunggu':
        return Icons.schedule_rounded;
      case 'Diproses':
        return Icons.autorenew_rounded;
      case 'Selesai':
        return Icons.check_circle_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');

    return '$day/$month/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final complaints = complaintData.complaints;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: navy,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Riwayat Komplain',
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: navy,
          ),
        ),
      ),

      body: complaints.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: complaints.length,
              itemBuilder: (context, index) {
                final complaint =
                    complaints[complaints.length - 1 - index];

                return _buildComplaintCard(complaint);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2FF),
                borderRadius: BorderRadius.circular(26),
              ),
              child: const Icon(
                Icons.inbox_outlined,
                color: navy,
                size: 42,
              ),
            ),

            const SizedBox(height: 22),

            Text(
              'Belum Ada Komplain',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: navy,
              ),
            ),

            const SizedBox(height: 9),

            Text(
              'Komplain yang Anda buat akan muncul '
              'di halaman ini.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: muted,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComplaintCard(dynamic complaint) {
    final statusColor = _getStatusColor(complaint.status);
    final statusIcon = _getStatusIcon(complaint.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(17),
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
          // Judul dan status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  complaint.title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: navy,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      statusIcon,
                      size: 13,
                      color: statusColor,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      complaint.status,
                      style: GoogleFonts.inter(
                        color: statusColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          // Deskripsi
          Text(
            complaint.description,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF475569),
              height: 1.6,
            ),
          ),

          const SizedBox(height: 17),

          const Divider(
            height: 1,
            color: Color(0xFFE8EDF5),
          ),

          const SizedBox(height: 13),

          // Kategori dan tanggal
          Wrap(
            spacing: 14,
            runSpacing: 8,
            children: [
              _buildInfoItem(
                Icons.category_outlined,
                complaint.category,
              ),

              _buildInfoItem(
                Icons.calendar_today_outlined,
                _formatDate(complaint.createdAt),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: muted,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
            color: muted,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

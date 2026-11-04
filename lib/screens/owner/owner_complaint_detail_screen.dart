
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/complaint_data.dart';
import '../../models/complaint.dart';

class OwnerComplaintDetailScreen extends StatefulWidget {
  final ComplaintData complaintData;
  final Complaint complaint;

  const OwnerComplaintDetailScreen({
    super.key,
    required this.complaintData,
    required this.complaint,
  });

  @override
  State<OwnerComplaintDetailScreen> createState() =>
      _OwnerComplaintDetailScreenState();
}

class _OwnerComplaintDetailScreenState
    extends State<OwnerComplaintDetailScreen> {
  static const Color navy = Color(0xFF0B1F4D);
  static const Color muted = Color(0xFF64748B);

  Color _statusColor(String status) {
    switch (status) {
      case 'Menunggu':
        return const Color(0xFFD97706);
      case 'Diproses':
        return const Color(0xFF2563EB);
      case 'Selesai':
        return const Color(0xFF15803D);
      default:
        return muted;
    }
  }

  void _updateStatus(String newStatus) {
    final success = widget.complaintData.updateComplaintStatus(
      id: widget.complaint.id,
      newStatus: newStatus,
    );

    if (!success) return;

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Status berhasil diubah menjadi $newStatus'),
        backgroundColor: navy,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ambil data terbaru berdasarkan ID komplain
    final currentComplaint = widget.complaintData.complaints.firstWhere(
      (item) => item.id == widget.complaint.id,
    );

    final status = currentComplaint.status;
    final statusColor = _statusColor(status);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Detail Komplain',
          style: GoogleFonts.inter(
            color: navy,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
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
                  Text(
                    'Informasi Laporan',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: navy,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _detailItem('Judul Komplain', currentComplaint.title),
                  _detailItem('Kategori', currentComplaint.category),
                  _detailItem(
                    'Tanggal',
                    '${currentComplaint.createdAt.day}/'
                    '${currentComplaint.createdAt.month}/'
                    '${currentComplaint.createdAt.year}',
                  ),
                  _detailItem(
                    'Deskripsi',
                    currentComplaint.description,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Status Saat Ini',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: muted,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.inter(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'Tindakan Pengelola',
              style: GoogleFonts.inter(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: navy,
              ),
            ),
            const SizedBox(height: 12),
            if (status == 'Menunggu')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _updateStatus('Diproses'),
                  icon: const Icon(Icons.autorenew_rounded),
                  label: const Text('Proses Komplain'),
                ),
              ),
            if (status == 'Diproses')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _updateStatus('Selesai'),
                  icon: const Icon(Icons.check_circle_outline_rounded),
                  label: const Text('Selesaikan Komplain'),
                ),
              ),
            if (status == 'Selesai')
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFF15803D),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Komplain sudah berhasil diselesaikan.',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF15803D),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _detailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: muted,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: navy,
            ),
          ),
        ],
      ),
    );
  }
}

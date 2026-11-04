
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/complaint_data.dart';
import '../../models/complaint.dart';
import 'owner_complaint_detail_screen.dart';

class OwnerComplaintListScreen extends StatefulWidget {
  final ComplaintData complaintData;

  const OwnerComplaintListScreen({
    super.key,
    required this.complaintData,
  });

  @override
  State<OwnerComplaintListScreen> createState() =>
      _OwnerComplaintListScreenState();
}

class _OwnerComplaintListScreenState
    extends State<OwnerComplaintListScreen> {
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

  IconData _statusIcon(String status) {
    switch (status) {
      case 'Menunggu':
        return Icons.schedule_rounded;
      case 'Diproses':
        return Icons.autorenew_rounded;
      case 'Selesai':
        return Icons.check_circle_rounded;
      default:
        return Icons.info_outline_rounded;
    }
  }

  Future<void> _openDetail(Complaint complaint) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OwnerComplaintDetailScreen(
          complaintData: widget.complaintData,
          complaint: complaint,
        ),
      ),
    );

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final complaints = widget.complaintData.complaints.reversed.toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Daftar Komplain',
          style: GoogleFonts.inter(
            color: navy,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
      body: complaints.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.inbox_outlined,
                      size: 65,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Belum Ada Komplain',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: navy,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      'Laporan dari penghuni akan muncul di sini.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: muted,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: complaints.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 13),
              itemBuilder: (context, index) {
                final complaint = complaints[index];
                final color = _statusColor(complaint.status);

                return InkWell(
                  onTap: () => _openDetail(complaint),
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: const Color(0xFFE8EDF5),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14,
                              color: muted,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          complaint.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: muted,
                          ),
                        ),
                        const SizedBox(height: 13),
                        Row(
                          children: [
                            const Icon(
                              Icons.category_outlined,
                              size: 15,
                              color: muted,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              complaint.category,
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: muted,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.10),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _statusIcon(complaint.status),
                                    size: 13,
                                    color: color,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    complaint.status,
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

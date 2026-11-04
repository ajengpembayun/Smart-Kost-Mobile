
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/complaint_data.dart';

class ComplaintFormScreen extends StatefulWidget {
  final ComplaintData complaintData;

  const ComplaintFormScreen({
    super.key,
    required this.complaintData,
  });

  @override
  State<ComplaintFormScreen> createState() =>
      _ComplaintFormScreenState();
}

class _ComplaintFormScreenState
    extends State<ComplaintFormScreen> {
  static const Color navy = Color(0xFF0B1F4D);
  static const Color blue = Color(0xFF1D4ED8);
  static const Color muted = Color(0xFF64748B);

  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedCategory = 'Fasilitas';

  final List<String> _categories = [
    'Fasilitas',
    'Kebersihan',
    'Keamanan',
    'Lainnya',
  ];

  void _submitComplaint() {
    if (_formKey.currentState!.validate()) {
      widget.complaintData.addComplaint(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _selectedCategory,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Komplain berhasil dikirim!'),
          backgroundColor: Color(0xFF15803D),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration({
    required String hint,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(
        fontSize: 12,
        color: const Color(0xFF94A3B8),
      ),
      prefixIcon: prefixIcon,
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFE2E8F0),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFFE2E8F0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: navy,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
    );
  }

  Widget _buildLabel(String label, {bool required = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: navy,
            ),
          ),
          if (required)
            Text(
              ' *',
              style: GoogleFonts.inter(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: navy,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Buat Komplain',
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: navy,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header informasi
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: navy,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: const Icon(
                        Icons.campaign_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      'Sampaikan Keluhan Anda',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 7),

                    Text(
                      'Bantu kami meningkatkan kenyamanan '
                      'hunian dengan melaporkan masalah '
                      'yang terjadi di lingkungan kos.',
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 11,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Formulir
              Text(
                'Detail Pengaduan',
                style: GoogleFonts.inter(
                  color: navy,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                'Lengkapi informasi berikut dengan benar.',
                style: GoogleFonts.inter(
                  color: muted,
                  fontSize: 11,
                ),
              ),

              const SizedBox(height: 22),

              // Judul
              _buildLabel('Judul Komplain'),

              TextFormField(
                controller: _titleController,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: navy,
                ),
                decoration: _inputDecoration(
                  hint: 'Contoh: AC kamar tidak dingin',
                  prefixIcon: const Icon(
                    Icons.edit_note_rounded,
                    color: muted,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Judul komplain wajib diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 21),

              // Kategori
              _buildLabel('Kategori Komplain'),

              DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                isExpanded: true,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: navy,
                ),
                decoration: _inputDecoration(
                  hint: 'Pilih kategori',
                  prefixIcon: const Icon(
                    Icons.category_outlined,
                    color: muted,
                  ),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: navy,
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 21),

              // Deskripsi
              _buildLabel('Deskripsi Komplain'),

              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                minLines: 4,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: navy,
                  height: 1.5,
                ),
                decoration: _inputDecoration(
                  hint: 'Jelaskan masalah yang Anda alami '
                      'secara detail...',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 85),
                    child: Icon(
                      Icons.description_outlined,
                      color: muted,
                    ),
                  ),
                ).copyWith(
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Deskripsi komplain wajib diisi';
                  }

                  if (value.trim().length < 5) {
                    return 'Deskripsi minimal 5 karakter';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 13),

              // Informasi tambahan
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    size: 15,
                    color: blue,
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      'Pastikan informasi yang diberikan '
                      'jelas agar pengelola dapat '
                      'menindaklanjuti laporan Anda.',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: muted,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // Tombol kirim
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _submitComplaint,
                  icon: const Icon(
                    Icons.send_rounded,
                    size: 18,
                  ),
                  label: Text(
                    'Kirim Komplain',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: navy,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}

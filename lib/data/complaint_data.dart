
import '../models/complaint.dart';

class ComplaintData {
  // Menyimpan seluruh data komplain sementara
  final List<Complaint> _complaints = [];

  // Mengambil daftar komplain
  List<Complaint> get complaints =>
      List.unmodifiable(_complaints);

  // Menghitung jumlah seluruh komplain
  int get totalComplaints => _complaints.length;

  // Menghitung komplain berdasarkan status
  int get waitingCount =>
      _complaints.where((c) => c.status == 'Menunggu').length;

  int get processingCount =>
      _complaints.where((c) => c.status == 'Diproses').length;

  int get completedCount =>
      _complaints.where((c) => c.status == 'Selesai').length;

  // Menambahkan komplain baru
  void addComplaint({
    required String title,
    required String description,
    required String category,
  }) {
    final newComplaint = Complaint(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      description: description,
      category: category,
      status: 'Menunggu',
      createdAt: DateTime.now(),
    );

    _complaints.add(newComplaint);
  }

  // Memperbarui status komplain
  bool updateComplaintStatus({
    required String id,
    required String newStatus,
  }) {
    const allowedStatuses = [
      'Menunggu',
      'Diproses',
      'Selesai',
    ];

    if (!allowedStatuses.contains(newStatus)) {
      return false;
    }

    final index = _complaints.indexWhere(
      (complaint) => complaint.id == id,
    );

    if (index == -1) {
      return false;
    }

    _complaints[index] = _complaints[index].copyWith(
      status: newStatus,
    );

    return true;
  }
}

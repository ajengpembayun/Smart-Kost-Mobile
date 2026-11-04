
class Complaint {
  final String id;
  final String title;
  final String description;
  final String category;
  final String status;
  final DateTime createdAt;

  Complaint({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.createdAt,
  });

  // Membuat salinan komplain dengan perubahan tertentu
  Complaint copyWith({
    String? status,
  }) {
    return Complaint(
      id: id,
      title: title,
      description: description,
      category: category,
      status: status ?? this.status,
      createdAt: createdAt,
    );
  }
}

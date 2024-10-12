class TaskModel {
  int? id;
  String title;
  String description;
  String imageUrl;
  bool isFavorite; // Tambahkan ini

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.isFavorite = false, // Default tidak favorit
  });

  // Convert Task object ke Map untuk dimasukkan ke database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite ? 1 : 0, // Simpan sebagai 1 atau 0
    };
  }

  // Convert Map object dari database ke TaskModel
  static TaskModel fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      isFavorite: map['isFavorite'] == 1, // Ambil dari database
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String title;
  final String category; // 'Học tập' hoặc 'Cuộc sống'
  final bool isCompleted;
  final DateTime? dueDate;
  final DateTime createdAt;
  final String userId;

  TaskModel({
    required this.id,
    required this.title,
    required this.category,
    this.isCompleted = false,
    this.dueDate,
    required this.createdAt,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'isCompleted': isCompleted,
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
      'createdAt': Timestamp.fromDate(createdAt),
      'userId': userId,
    };
  }

  factory TaskModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return TaskModel(
      id: doc.id,
      title: data['title'] ?? '',
      category: data['category'] ?? 'Học tập',
      isCompleted: data['isCompleted'] ?? false,
      dueDate: data['dueDate'] != null ? (data['dueDate'] as Timestamp).toDate() : null,
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      userId: data['userId'] ?? '',
    );
  }

  TaskModel copyWith({
    String? title,
    String? category,
    bool? isCompleted,
    DateTime? dueDate,
  }) {
    return TaskModel(
      id: id,
      title: title ?? this.title,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt,
      userId: userId,
    );
  }
}

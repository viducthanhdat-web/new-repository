import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';
import 'firebase_service.dart';

class TaskService {
  final CollectionReference _tasksRef =
      FirebaseFirestore.instance.collection('tasks');

  // Lấy stream danh sách task thời gian thực theo userId
  Stream<List<TaskModel>> getTasksStream(String userId) {
    if (userId.isEmpty) {
      return Stream.value([]);
    }

    return _tasksRef
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => TaskModel.fromFirestore(doc))
          .toList();
    });
  }

  // Thêm công việc mới
  Future<void> addTask({
    required String title,
    required String category,
    required String userId,
    DateTime? dueDate,
  }) async {
    final docRef = _tasksRef.doc();
    final newTask = TaskModel(
      id: docRef.id,
      title: title,
      category: category,
      isCompleted: false,
      dueDate: dueDate,
      createdAt: DateTime.now(),
      userId: userId,
    );

    await docRef.set(newTask.toMap());
    await AppFirebaseService.instance.logTaskCreated(category);
  }

  // Chuyển đổi trạng thái hoàn thành (Toggle)
  Future<void> toggleTaskStatus(String taskId, bool currentStatus) async {
    final newStatus = !currentStatus;
    await _tasksRef.doc(taskId).update({
      'isCompleted': newStatus,
    });

    if (newStatus) {
      await AppFirebaseService.instance.logTaskCompleted(taskId);
    }
  }

  // Xóa công việc
  Future<void> deleteTask(String taskId) async {
    await _tasksRef.doc(taskId).delete();
  }
}

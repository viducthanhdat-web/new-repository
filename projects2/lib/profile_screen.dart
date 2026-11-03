import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'models/task_model.dart';
import 'login_screen.dart';
import 'services/task_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? 'Người dùng Ẩn danh';
    final email = user?.email ?? 'Chưa liên kết email';
    final photoURL = user?.photoURL;
    final userId = user?.uid ?? '';

    String initials = "GU";
    final trimmedName = displayName.trim();
    if (trimmedName.isNotEmpty && trimmedName != 'Người dùng Ẩn danh') {
      List<String> parts = trimmedName.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
      if (parts.length > 1) {
        initials = "${parts.first[0]}${parts.last[0]}".toUpperCase();
      } else if (parts.isNotEmpty) {
        initials = parts.first[0].toUpperCase();
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Hồ sơ', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // Avatar (Hỗ trợ Firebase Storage / Google photoURL)
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0xFFE0E5FF),
              backgroundImage: photoURL != null ? NetworkImage(photoURL) : null,
              child: photoURL == null
                  ? Text(
                      initials,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4561E9),
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 16),
            // Thông tin user
            Text(displayName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(email, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check, color: Colors.green, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    user?.isAnonymous == true ? 'Tài khoản dùng thử' : 'Đã liên kết tài khoản Google',
                    style: const TextStyle(color: Colors.green, fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Thông số công việc (Đồng bộ thời gian thực từ Firestore)
            StreamBuilder<List<TaskModel>>(
              stream: TaskService().getTasksStream(userId),
              builder: (context, snapshot) {
                final tasks = snapshot.data ?? [];
                final completedCount = tasks.where((t) => t.isCompleted).length;
                final pendingCount = tasks.where((t) => !t.isCompleted).length;
                final percentage = tasks.isNotEmpty
                    ? '${((completedCount / tasks.length) * 100).toInt()}%'
                    : '0%';

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatItem(number: '$completedCount', label: 'Việc đã xong'),
                      _StatItem(number: '$pendingCount', label: 'Đang chờ'),
                      _StatItem(number: percentage, label: 'Hoàn thành'),
                    ],
                  ),
                );
              },
            ),

            const Spacer(),
            // Nút Đăng xuất
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () => _signOut(context),
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text(
                    'Đăng xuất',
                    style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String number;
  final String label;

  const _StatItem({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(number, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

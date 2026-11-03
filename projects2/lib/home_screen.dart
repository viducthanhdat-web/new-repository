import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'models/task_model.dart';
import 'profile_screen.dart';
import 'services/firebase_service.dart';
import 'services/task_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskService _taskService = TaskService();
  String _selectedCategory = 'Tất cả'; // 'Tất cả', 'Học tập', 'Cuộc sống'

  // Mở BottomSheet thêm công việc mới
  void _showAddTaskSheet(BuildContext context, String userId) {
    final titleController = TextEditingController();
    String taskCategory = 'Học tập';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Thêm việc mới',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: titleController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Nhập tên công việc...',
                      filled: true,
                      fillColor: const Color(0xFFF5F7FA),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Chọn danh mục:', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ChoiceChip(
                        label: const Text('Học tập'),
                        selected: taskCategory == 'Học tập',
                        selectedColor: const Color(0xFF4561E9).withValues(alpha: 0.2),
                        onSelected: (selected) {
                          if (selected) setSheetState(() => taskCategory = 'Học tập');
                        },
                      ),
                      const SizedBox(width: 8),
                      ChoiceChip(
                        label: const Text('Cuộc sống'),
                        selected: taskCategory == 'Cuộc sống',
                        selectedColor: Colors.orange.withValues(alpha: 0.2),
                        onSelected: (selected) {
                          if (selected) setSheetState(() => taskCategory = 'Cuộc sống');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4561E9),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async {
                        final title = titleController.text.trim();
                        if (title.isNotEmpty) {
                          await _taskService.addTask(
                            title: title,
                            category: taskCategory,
                            userId: userId,
                          );
                          if (context.mounted) Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        'Lưu công việc',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? '';
    final displayName = user?.displayName ?? 'Khách';

    // Initials cho Avatar
    String initials = "GU";
    final trimmedName = displayName.trim();
    if (trimmedName.isNotEmpty && trimmedName != 'Khách') {
      List<String> parts = trimmedName.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
      if (parts.length > 1) {
        initials = "${parts.first[0]}${parts.last[0]}".toUpperCase();
      } else if (parts.isNotEmpty) {
        initials = parts.first[0].toUpperCase();
      }
    }

    // Remote Config message
    final welcomeBanner = AppFirebaseService.instance.getWelcomeMessage();
    final showBanner = AppFirebaseService.instance.isBannerEnabled();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: StreamBuilder<List<TaskModel>>(
          stream: _taskService.getTasksStream(userId),
          builder: (context, snapshot) {
            final allTasks = snapshot.data ?? [];
            final completedCount = allTasks.where((t) => t.isCompleted).length;
            final totalCount = allTasks.length;
            final double progress = totalCount > 0 ? (completedCount / totalCount) : 0.0;

            // Lọc theo danh mục
            final filteredTasks = _selectedCategory == 'Tất cả'
                ? allTasks
                : allTasks.where((t) => t.category == _selectedCategory).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header (Appbar giả)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProfileScreen()),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFFE0E5FF),
                          foregroundColor: const Color(0xFF4561E9),
                          child: Text(initials, style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hôm nay',
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          ),
                          Text(
                            'Chào $displayName!',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.notifications_none, color: Colors.black54),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Firebase Cloud Messaging đang hoạt động!')),
                          );
                        },
                      )
                    ],
                  ),
                ),

                // Remote Config Banner (nếu có cấu hình)
                if (showBanner && welcomeBanner.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4561E9).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF4561E9).withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.campaign, color: Color(0xFF4561E9), size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              welcomeBanner,
                              style: const TextStyle(fontSize: 13, color: Color(0xFF4561E9), fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 8),

                // Progress Card (Đồng bộ thời gian thực từ Firestore)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4561E9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Tiến độ hôm nay', style: TextStyle(color: Colors.white70, fontSize: 14)),
                            const SizedBox(height: 8),
                            Text('$completedCount/$totalCount việc',
                                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(
                              totalCount == 0
                                  ? 'Chưa có việc nào hôm nay'
                                  : progress == 1.0
                                      ? 'Tuyệt vời! Đã hoàn thành tất cả!'
                                      : progress >= 0.5
                                          ? 'Đã hơn nửa chặng, cố lên!'
                                          : 'Bắt đầu ngày mới đầy năng lượng!',
                              style: const TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                          ],
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(
                                value: progress,
                                backgroundColor: Colors.white24,
                                color: Colors.white,
                                strokeWidth: 6,
                              ),
                            ),
                            Text('${(progress * 100).toInt()}%',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Danh mục Tabs: Tất cả, Học tập, Cuộc sống
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: ['Tất cả', 'Học tập', 'Cuộc sống'].map((category) {
                      final isSelected = _selectedCategory == category;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          selected: isSelected,
                          label: Text(category),
                          selectedColor: const Color(0xFF4561E9).withValues(alpha: 0.15),
                          checkmarkColor: const Color(0xFF4561E9),
                          labelStyle: TextStyle(
                            color: isSelected ? const Color(0xFF4561E9) : Colors.black87,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          onSelected: (_) {
                            setState(() => _selectedCategory = category);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 8),

                // Danh sách việc cần làm (Real-time Firestore)
                Expanded(
                  child: snapshot.connectionState == ConnectionState.waiting
                      ? const Center(child: CircularProgressIndicator(color: Color(0xFF4561E9)))
                      : filteredTasks.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.task_alt, size: 64, color: Colors.grey[300]),
                                  const SizedBox(height: 12),
                                  Text(
                                    _selectedCategory == 'Tất cả'
                                        ? 'Chưa có công việc nào.\nBấm dấu (+) bên dưới để thêm!'
                                        : 'Không có việc nào trong mục "$_selectedCategory".',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                              itemCount: filteredTasks.length,
                              itemBuilder: (context, index) {
                                final task = filteredTasks[index];
                                return Dismissible(
                                  key: Key(task.id),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.red[400],
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Icon(Icons.delete, color: Colors.white),
                                  ),
                                  onDismissed: (_) {
                                    _taskService.deleteTask(task.id);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.03),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            task.isCompleted
                                                ? Icons.check_circle
                                                : Icons.radio_button_unchecked,
                                            color: task.isCompleted
                                                ? const Color(0xFF4561E9)
                                                : Colors.grey[400],
                                          ),
                                          onPressed: () {
                                            _taskService.toggleTaskStatus(task.id, task.isCompleted);
                                          },
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            task.title,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              decoration: task.isCompleted
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                              color: task.isCompleted
                                                  ? Colors.grey
                                                  : Colors.black87,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: task.category == 'Học tập'
                                                ? Colors.blue[50]
                                                : Colors.orange[50],
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            task.category,
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: task.category == 'Học tập'
                                                  ? Colors.blue[800]
                                                  : Colors.orange[800],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF4561E9),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 2) {
            _showAddTaskSheet(context, userId);
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Danh sách'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, color: Color(0xFF4561E9), size: 40),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Thông báo'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Cài đặt'),
        ],
      ),
    );
  }
}

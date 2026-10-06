import 'package:flutter/material.dart';
void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile',
      theme: ThemeData(useMaterial3: true),
      home: const ProfileScreen(),
    );
  }
}
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const String name = 'Vi Đức Thành Đạt';
  static const String studentId = '066206001928';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _SquareButton(
                    icon: Icons.arrow_back,
                    color: Colors.black87,
                    borderColor: Colors.grey.shade300,
                    onTap: () => Navigator.maybePop(context),
                  ),
                ],
              ),
              const SizedBox(height: 90),
          const CircleAvatar(
            radius: 56,
            backgroundColor: Color(0xFFCFE3F5),
            backgroundImage: AssetImage('assets/avatar.jpg'),
              ),
              const SizedBox(height: 16),
              const Text(
                name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                studentId,
                style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _SquareButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color borderColor;
  final VoidCallback onTap;

  const _SquareButton({
    required this.icon,
    required this.color,
    required this.borderColor,
    required this.onTap,
  }
  );
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}

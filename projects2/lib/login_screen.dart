import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home_screen.dart';
import 'services/firebase_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  // Hàm xử lý hiển thị thông báo
  void _showMessage(String message, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Đăng nhập bằng Google
  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      if (kIsWeb) {
        // Trên nền tảng Web: Firebase Auth hỗ trợ signInWithPopup mà không cần cấu hình ClientID thủ công
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
      } else {
        // Trên Android / iOS
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) {
          setState(() => _isLoading = false);
          return; // Người dùng hủy đăng nhập
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
      }
      
      await AppFirebaseService.instance.logLoginSuccess('google');
      if (!mounted) return;
      _showMessage('Đăng nhập Google thành công!', false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      _showMessage('Lỗi đăng nhập: ${e.toString()}', true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Đăng nhập ẩn danh (Dùng thử)
  Future<void> _signInAnonymously() async {
    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.signInAnonymously();
      await AppFirebaseService.instance.logLoginSuccess('anonymous');
      if (!mounted) return;
      _showMessage('Đăng nhập dùng thử thành công!', false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      _showMessage('Lỗi đăng nhập ẩn danh: ${e.toString()}', true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              // Icon Logo giả lập
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFF4561E9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.check_circle_outline, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 32),
              const Text(
                'Chào mừng đến với\nUTH Todo',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Đăng nhập để lưu công việc và đồng bộ\ntrên mọi thiết bị của bạn.',
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
              const Spacer(),
              
              if (_isLoading)
                const Center(child: CircularProgressIndicator(color: Color(0xFF4561E9)))
              else ...[
                // Nút Đăng nhập Google
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: _signInWithGoogle,
                    icon: const Icon(Icons.g_mobiledata, size: 30, color: Colors.red),
                    label: const Text(
                      'Tiếp tục với Google',
                      style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      side: const BorderSide(color: Colors.black12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(child: Text('hoặc', style: TextStyle(color: Colors.grey))),
                const SizedBox(height: 16),
                
                // Nút Dùng thử
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: _signInAnonymously,
                    child: const Text(
                      'Dùng thử không cần tài khoản',
                      style: TextStyle(color: Color(0xFF4561E9), fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              const Text(
                'Khi tiếp tục, bạn đồng ý với Điều khoản sử dụng và Chính sách quyền riêng tư của UTH Todo.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

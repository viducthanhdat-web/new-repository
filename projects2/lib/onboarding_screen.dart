import 'package:flutter/material.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      'title': 'Mọi việc, gọn trong một chỗ',
      'subtitle': 'Ghi lại bài tập, việc nhà, lịch hẹn. Không còn quên việc nào.',
      'widget': const Illustration1(),
    },
    {
      'title': 'Chia theo Học tập và Cuộc sống',
      'subtitle': 'Mỗi việc có nhóm riêng, nhìn là biết hôm nay cần lo gì.',
      'widget': const Illustration2(),
    },
    {
      'title': 'Nhắc đúng lúc',
      'subtitle': 'Bật thông báo để UTH Todo nhắc bạn trước hạn chót.',
      'widget': const Illustration3(),
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  void _onSkip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar Area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4561E9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             Row(
                               mainAxisSize: MainAxisSize.min,
                               children: [
                                 const Icon(Icons.check_circle, color: Colors.white, size: 8),
                                 const SizedBox(width: 2),
                                 Container(width: 6, height: 2, color: Colors.white),
                               ]
                             ),
                             const SizedBox(height: 2),
                             Row(
                               mainAxisSize: MainAxisSize.min,
                               children: [
                                 const Icon(Icons.radio_button_unchecked, color: Colors.white54, size: 8),
                                 const SizedBox(width: 2),
                                 Container(width: 6, height: 2, color: Colors.white54),
                               ]
                             ),
                           ],
                        )
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'UTH Todo',
                        style: TextStyle(
                          color: Color(0xFF4561E9),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: _onSkip,
                    child: const Text(
                      'Bỏ qua',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    title: _onboardingData[index]['title'],
                    subtitle: _onboardingData[index]['subtitle'],
                    imageWidget: _onboardingData[index]['widget'],
                  );
                },
              ),
            ),

            // Bottom Area (Indicators and Button)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    children: List.generate(
                      _onboardingData.length,
                      (index) => buildDot(index, context),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4561E9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentPage == _onboardingData.length - 1 ? 'Bắt đầu ngay' : 'Tiếp tục',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return Container(
      height: 6,
      width: _currentPage == index ? 20 : 6,
      margin: const EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: _currentPage == index ? const Color(0xFF4561E9) : Colors.grey[300],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget imageWidget;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: imageWidget,
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
          const Expanded(flex: 1, child: SizedBox()), // Push content slightly up
        ],
      ),
    );
  }
}

// --- Mock Illustrations ---

class Illustration1 extends StatelessWidget {
  const Illustration1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 280,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F5FC),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildListItem(true),
          const SizedBox(height: 16),
          _buildListItem(false),
          const SizedBox(height: 16),
          _buildListItem(false),
        ],
      ),
    );
  }

  Widget _buildListItem(bool isChecked) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            isChecked ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isChecked ? const Color(0xFF4561E9) : Colors.grey[300],
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Illustration2 extends StatelessWidget {
  const Illustration2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 280,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F5FC),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildFolderItem('Học tập', Colors.blue[50]!, Colors.blue[800]!),
          const SizedBox(height: 16),
          _buildFolderItem('Cuộc sống', Colors.orange[50]!, Colors.orange[800]!),
        ],
      ),
    );
  }

  Widget _buildFolderItem(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              text,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: textColor),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 6,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
    );
  }
}

class Illustration3 extends StatelessWidget {
  const Illustration3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 280,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F5FC),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.notifications_none,
              color: Color(0xFF4561E9),
              size: 40,
            ),
          ),
          Positioned(
            bottom: 50,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                'Ôn bài Toán lúc 19:00',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

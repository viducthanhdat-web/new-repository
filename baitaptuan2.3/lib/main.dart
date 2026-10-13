import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GradeBoardScreen(),
    );
  }
}
class Student {
  String name;
  double? score;

  Student({required this.name, this.score});
}

class GradeBoardScreen extends StatelessWidget {
  final List<Student> students = [
    Student(name: 'Nguyễn Văn An', score: 9.0),
    Student(name: 'Trần Thị Bình', score: 7.2),
    Student(name: 'Lê Minh Chi', score: null),
    Student(name: 'Phạm Quốc Dũng', score: 4.5),
    Student(name: 'Võ Thành Em', score: 5.8),
  ];

  GradeBoardScreen({super.key});

  Map<String, dynamic> getGrade(double? score) {
    if (score == null) {
      return {"label": "Chưa có điểm", "color": Colors.grey};
    } else if (score >= 8.0) {
      return {"label": "Giỏi", "color": Colors.green};
    } else if (score >= 6.50) {
      return {"label": "Khá", "color": Colors.blue};
    } else if (score >= 5.0) {
      return {"label": "Trung bình", "color": Colors.orange};
    } else {
      return {"label": "Yếu", "color": Colors.red};
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalScore = 0;
    int countHasScore = 0;
    int countExcellent = 0;
    int countNull = 0;
    double maxScore = 0;

    for (var student in students) {
      if (student.score == null) {
        countNull++;
      } else {
        totalScore += student.score!;
        countHasScore++;
        if (student.score! >= 8.0) {
          countExcellent++;
        }
        if (student.score! > maxScore) {
          maxScore = student.score!;
        }
      }
    }
    double averageScore = countHasScore > 0 ? totalScore / countHasScore : 0;
    String avgString = averageScore.toStringAsFixed(2);
    const primaryBlue = Color(0xFF2B4162);
    const bgColor = Color(0xFFF3F4F6);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        title: const Text(
            'Bảng điểm lớp', style: TextStyle(color: Colors.white)),
        elevation: 0,
// Sửa 'action' thành 'actions'
        actions: const [
          Icon(Icons.wifi, color: Colors.white),
          SizedBox(width: 8),
          Icon(Icons.battery_full, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Điểm trung bình lớp',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    avgString,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(height: 1, color: Colors.white24),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Giỏi', style: TextStyle(color: Colors
                              .white70, fontSize: 12)),
                          const SizedBox(height: 4),
                          Text(
                            countExcellent.toString(),
                            style: const TextStyle(color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Chưa có điểm', style: TextStyle(
                              color: Colors.white70, fontSize: 12)),
                          const SizedBox(height: 4),
                          Text(
                            countNull.toString(),
                            style: const TextStyle(color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Cao nhất', style: TextStyle(color: Colors
                              .white70, fontSize: 12)),
                          const SizedBox(height: 4),
                          Text(
                            maxScore.toString(),
                            style: const TextStyle(color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'DANH SÁCH · ${students.length} SINH VIÊN',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 12),
            for (var student in students)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.name,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        getGrade(student.score)['label'],
                        style: TextStyle(
                          fontSize: 13,
                          color: getGrade(student.score)['color'],
                        ),
                      ),

                    ],
                  ),
                    Text(
                      student.score != null ? student.score.toString() : '_',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
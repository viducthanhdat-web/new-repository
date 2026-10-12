import 'package:flutter/material.dart';
class Student{
  final String name;
  final String? email;
  final String? phone;
  Student({
    required this.name,
    this.email,
    this.phone,
}
      );
}
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: StudentListScreen(),
  ));
}

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Student> students = [
      Student(
        name: 'Nguyễn Văn An',
        email: 'an@sv.edu.vn',
        phone: '0901 234 567',
      ),
      Student(
          name: 'Trần Thị Bình',
          email: null,
          phone: '0912 888 999'
      ),
      Student(
        name: 'Lê MInh Trí',
        email: 'chi@sv.edu.vn',
        phone: null,
      ),
      Student(
        name: 'Phạm Quốc Dũng',
        email: null,
        phone: null,
      ),
      Student(
        name: 'Võ Thành Em',
        email: 'em@sv.edu.vn',
        phone: '0933 111 222',
      ),

    ];
    int missingEmailCount = 0;
    for (int i = 0; i < students.length; i++) {
      if (students[i].email == null) {
        missingEmailCount++;
      }
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text(
          'Danh sách sinh viên',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1E3A70),
        elevation: 0,
      ),
      body: Column(
        children: [

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [

                for (final student in students)
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0A000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          student.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 6),
                       
                        Row(
                          children: [
                            const Text(
                              'Email: ',
                              style: TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                            Text(
                              student.email ?? 'Chưa cập nhật',
                              style: TextStyle(
                                fontSize: 13,
                                color: student.email == null
                                    ? const Color(0xFFD97706)
                                    : const Color(0xFF4B5563),
                                fontStyle: student.email == null
                                    ? FontStyle.italic
                                    : FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Text(
                              'SĐT: ',
                              style: TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                            Text(
                              student.phone ?? 'Chưa cập nhật',
                              style: TextStyle(
                                fontSize: 13,
                                color: student.phone == null
                                    ? const Color(0xFFD97706)
                                    : const Color(0xFF4B5563),
                                fontStyle: student.phone == null
                                    ? FontStyle.italic
                                    : FontStyle.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),


          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tổng: ${students.length} sinh viên',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF334155),
                  ),
                ),
                Text(
                  'Thiếu email: $missingEmailCount',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF334155),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


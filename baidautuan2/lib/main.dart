import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorPracticeScreen(),
    );
  }
}

class CalculatorPracticeScreen extends StatefulWidget {
  const CalculatorPracticeScreen({super.key});

  @override
  State<CalculatorPracticeScreen> createState() => _CalculatorPracticeScreenState();
}

class _CalculatorPracticeScreenState extends State<CalculatorPracticeScreen> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();

  String? _selectedOp; // Lưu phép toán đang được chọn (+, -, *, /)
  String _resultText = ''; // Lưu chuỗi kết quả hiển thị

  void _calculate(String op) {
    setState(() {
      _selectedOp = op;
      double? num1 = double.tryParse(_num1Controller.text);
      double? num2 = double.tryParse(_num2Controller.text);

      if (num1 == null || num2 == null) {
        _resultText = '';
        return;
      }

      double res = 0;
      if (op == '+') {
        res = num1 + num2;
      } else if (op == '-') {
        res = num1 - num2;
      } else if (op == '*') {
        res = num1 * num2;
      } else if (op == '/') {
        if (num2 == 0) {
          _resultText = 'Không thể chia cho 0';
          return;
        }
        res = num1 / num2;
      }
      if (res % 1 == 0) {
        _resultText = res.toInt().toString();
      } else {
        _resultText = res.toStringAsFixed(2);
      }
    });
  }
  Widget _buildOperatorButton(String op, Color color) {
    bool isSelected = _selectedOp == op;

    return GestureDetector(
      onTap: () => _calculate(op),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(color: Colors.black, width: 2.5)
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          op,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _num1Controller.dispose();
    _num2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề
              const Center(
                child: Text(
                  'Thực hành 03',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 60),

              // Ô nhập số thứ 1
              TextField(
                controller: _num1Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
                onChanged: (_) {
                  if (_selectedOp != null) _calculate(_selectedOp!);
                },
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOperatorButton('+', const Color(0xFFD9534F)),
                  _buildOperatorButton('-', const Color(0xFFEAA850)),
                  _buildOperatorButton('*', const Color(0xFF5352ED)),
                  _buildOperatorButton('/', const Color(0xFF2F3542)),
                ],
              ),

              const SizedBox(height: 20),
              TextField(
                controller: _num2Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
                onChanged: (_) {
                  if (_selectedOp != null) _calculate(_selectedOp!);
                },
              ),

              const SizedBox(height: 24),
              Text(
                'Kết quả: $_resultText',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
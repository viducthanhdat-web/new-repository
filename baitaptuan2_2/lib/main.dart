import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GradeEvaluationScreen(),
  ));
}

class GradeEvaluationScreen  extends StatelessWidget {
  const GradeEvaluationScreen({super.key});

  String getRank(double score) {
    if (score < 0 || score >10){
      return ' không hợp lệ ';
    }else if (score >= 8.0){
      return 'giỏi';
    }else if (score >= 6.5){
      return 'khá';
    }else if (score >=5.0){
      return 'trung bình';
    }else{
      return 'yếu';
    }
  }
  Color getRankColor(String rank){
    if (rank == 'giỏi'){
      return Colors.green;
    }else if (rank == 'khá'){
      return Colors.blue;
    }else if (rank =='trung bình'){
      return Colors.orange;
    }else if (rank == 'yếu'){
      return Colors.red;
  }else{
    return Colors.grey;
    }
  }
  Color getRankBgColor(String rank){
    if (rank == 'giỏi'){
      return Colors.greenAccent;
    }else if (rank =='khá'){
      return Colors.lightBlueAccent;
    }else if(rank=='trung bình'){
      return Colors.deepOrangeAccent;
    }else if(rank=='yếu'){
      return Colors.red.shade900;
    }else {
      return Colors.black26;
    }
  }
  @override
  Widget build(BuildContext context) {
    const double mainScore = 8.5;
    final String mainRank = getRank(mainScore);
    const List<double> extraScores = [9,7, 5.5, 3, 11];
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'xếp hạng học lực',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo.shade900,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0,2),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Điểm trung bình',
                  style: const TextStyle(
                    fontSize:13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$mainScore',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: getRankBgColor(mainRank),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    mainRank,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: getRankColor(mainRank),
                ),
                ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 4),
            child: const Text(
              'KIỂM TRA THÊM',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height:8),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.05),
                  blurRadius: 4,
                  offset: const Offset(0,2),
                ),
              ],
            ),
            child: Column(
              children:[
                for (int i=0; i< extraScores.length;i++)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      border: i != extraScores.length -1
                          ? Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      )
                      : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Điểm ${extraScores[i] % 1== 0 ? extraScores[i].toInt() : extraScores[i]} ',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: getRankBgColor(getRank(extraScores[i])),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            getRank(extraScores[i]),
                            style: TextStyle(
                              fontSize:12,
                              fontWeight: FontWeight.w600,
                              color: getRankColor(getRank(extraScores[i])),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );

  }
}

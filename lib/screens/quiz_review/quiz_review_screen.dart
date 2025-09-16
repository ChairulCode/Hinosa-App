// screens/quiz_review_screen.dart
import 'package:flutter/material.dart';
import '../model/quiz_data.dart';

class QuizReviewScreen extends StatelessWidget {
  final List<Map<String, dynamic>> userAnswers;
  final int score;
  final int totalQuestions;

  const QuizReviewScreen({
    super.key,
    required this.userAnswers,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Review Jawaban",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Summary Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSummaryItem(
                  icon: Icons.quiz,
                  label: 'Total Soal',
                  value: totalQuestions.toString(),
                  color: Colors.blue,
                ),
                _buildSummaryItem(
                  icon: Icons.check_circle,
                  label: 'Benar',
                  value: score.toString(),
                  color: Colors.green,
                ),
                _buildSummaryItem(
                  icon: Icons.cancel,
                  label: 'Salah',
                  value: (totalQuestions - score).toString(),
                  color: Colors.red,
                ),
                _buildSummaryItem(
                  icon: Icons.percent,
                  label: 'Akurasi',
                  value:
                      '${((score / totalQuestions) * 100).toStringAsFixed(0)}%',
                  color: Colors.orange,
                ),
              ],
            ),
          ),

          // Filter Buttons
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: FilterChip(
                    label: const Text('Semua'),
                    selected: true,
                    onSelected: (selected) {},
                    selectedColor: Colors.blue[100],
                    labelStyle: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilterChip(
                    label: const Text('Benar'),
                    selected: false,
                    onSelected: (selected) {},
                    selectedColor: Colors.green[100],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilterChip(
                    label: const Text('Salah'),
                    selected: false,
                    onSelected: (selected) {},
                    selectedColor: Colors.red[100],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: userAnswers.length,
              itemBuilder: (context, index) {
                final answer = userAnswers[index];
                final question = answer['question'] as QuizQuestion2;
                final isCorrect = answer['isCorrect'] as bool;
                final selectedAnswer = answer['selectedAnswer'] as String;

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isCorrect ? Colors.green[200]! : Colors.red[200]!,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ExpansionTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCorrect ? Colors.green[50] : Colors.red[50],
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                isCorrect ? Colors.green[700] : Colors.red[700],
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      question.question,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Row(
                      children: [
                        Icon(
                          isCorrect ? Icons.check_circle : Icons.cancel,
                          color: isCorrect ? Colors.green : Colors.red,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isCorrect ? 'Benar' : 'Salah',
                          style: TextStyle(
                            color:
                                isCorrect ? Colors.green[700] : Colors.red[700],
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            question.chapter,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pilihan Jawaban:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Options
                            ...question.options.asMap().entries.map((entry) {
                              int optionIndex = entry.key;
                              String option = entry.value;
                              bool isSelectedAnswer = option == selectedAnswer;
                              bool isCorrectAnswer =
                                  option == question.correctAnswer;

                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color:
                                      isCorrectAnswer
                                          ? Colors.green[50]
                                          : isSelectedAnswer && !isCorrectAnswer
                                          ? Colors.red[50]
                                          : Colors.grey[50],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color:
                                        isCorrectAnswer
                                            ? Colors.green[300]!
                                            : isSelectedAnswer &&
                                                !isCorrectAnswer
                                            ? Colors.red[300]!
                                            : Colors.grey[300]!,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            isCorrectAnswer
                                                ? Colors.green
                                                : isSelectedAnswer &&
                                                    !isCorrectAnswer
                                                ? Colors.red
                                                : Colors.grey,
                                      ),
                                      child: Center(
                                        child: Text(
                                          String.fromCharCode(65 + optionIndex),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        option,
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ),
                                    if (isCorrectAnswer)
                                      const Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 20,
                                      )
                                    else if (isSelectedAnswer &&
                                        !isCorrectAnswer)
                                      const Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                  ],
                                ),
                              );
                            }).toList(),

                            const SizedBox(height: 16),

                            // Explanation
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.blue[200]!),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.lightbulb_outline,
                                        color: Colors.blue[700],
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Penjelasan:',
                                        style: TextStyle(
                                          color: Colors.blue[700],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    question.explanation,
                                    style: TextStyle(
                                      color: Colors.blue[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}

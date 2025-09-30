// screens/quiz_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import '../screens/model/quiz_data.dart';

class QuizScreen extends StatefulWidget {
  final String category;
  final String difficulty;
  final int questionCount;
  final int duration;
  final List<String>? chapters;
  final String? source;

  const QuizScreen({
    super.key,
    required this.category,
    required this.difficulty,
    required this.questionCount,
    required this.duration,
    this.chapters,
    this.source,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<QuizQuestion2> questions;
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  int score = 0;
  bool isAnswered = false;
  late int remainingTime;
  bool isQuizCompleted = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeQuiz();
    remainingTime = widget.duration * 60;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _initializeQuiz() {
    if (widget.source != null) {
      questions = QuizData.getQuestionsBySource(
        widget.source!,
        widget.questionCount,
      );
    } else if (widget.chapters != null && widget.chapters!.isNotEmpty) {
      questions = QuizData.getQuestionsByChapters(widget.chapters!);
      questions.shuffle();
      questions = questions.take(widget.questionCount).toList();
    } else {
      questions = QuizData.getQuestionsByDifficulty(widget.difficulty);
    }

    if (questions.length > widget.questionCount) {
      questions = questions.take(widget.questionCount).toList();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          _timer?.cancel();
          isQuizCompleted = true;
        }
      });
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (isQuizCompleted) {
      return _buildResultScreen();
    }

    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('${widget.category}'),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text(
                'Tidak ada soal yang tersedia',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Silakan pilih kategori yang lain'),
            ],
          ),
        ),
      );
    }

    final currentQuestion = questions[currentQuestionIndex];

    return WillPopScope(
      onWillPop: () async {
        _showExitDialog();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 218, 4, 11),
                    Color.fromARGB(255, 180, 10, 16),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min, // ✅ biar tinggi ikut isi
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: _showExitDialog,
                          ),
                          Expanded(
                            child: Text(
                              widget.category,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _formatTime(remainingTime),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${currentQuestionIndex + 1}/${questions.length}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    LinearProgressIndicator(
                      value: (currentQuestionIndex + 1) / questions.length,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.book, color: Colors.blue[700]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Bab: ${currentQuestion.chapter}',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.purple[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.quiz, color: Colors.purple),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Pertanyaan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      currentQuestion.question,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Expanded(
                child: ListView.builder(
                  itemCount: currentQuestion.options.length,
                  itemBuilder: (context, index) {
                    final option = currentQuestion.options[index];
                    final isSelected = selectedAnswer == option;
                    final isCorrect = option == currentQuestion.correctAnswer;

                    Color cardColor = Colors.white;
                    Color borderColor = Colors.grey[300]!;
                    Color textColor = Colors.black87;

                    if (isAnswered) {
                      if (isCorrect) {
                        cardColor = Colors.green[50]!;
                        borderColor = Colors.green;
                        textColor = Colors.green[700]!;
                      } else if (isSelected && !isCorrect) {
                        cardColor = Colors.red[50]!;
                        borderColor = Colors.red;
                        textColor = Colors.red[700]!;
                      }
                    } else if (isSelected) {
                      cardColor = Colors.blue[50]!;
                      borderColor = Colors.blue;
                      textColor = Colors.blue[700]!;
                    }

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: isAnswered ? null : () => _selectAnswer(option),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: borderColor, width: 2),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: borderColor,
                                ),
                                child: Center(
                                  child: Text(
                                    String.fromCharCode(65 + index),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: textColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              if (isAnswered && isCorrect)
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                              if (isAnswered && isSelected && !isCorrect)
                                const Icon(Icons.cancel, color: Colors.red),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              if (isAnswered) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.amber[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.amber[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lightbulb, color: Colors.amber[700]),
                          const SizedBox(width: 8),
                          Text(
                            'Penjelasan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.amber[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currentQuestion.explanation,
                        style: TextStyle(color: Colors.amber[700], height: 1.3),
                      ),
                    ],
                  ),
                ),
              ],

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedAnswer == null ? null : _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 218, 4, 11),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    currentQuestionIndex == questions.length - 1
                        ? 'Selesai'
                        : 'Lanjut',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      isAnswered = true;
      if (answer == questions[currentQuestionIndex].correctAnswer) {
        score++;
      }
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        isAnswered = false;
      });
    } else {
      setState(() {
        isQuizCompleted = true;
      });
    }
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Keluar dari Quiz?'),
            content: const Text(
              'Progress quiz akan hilang. Yakin ingin keluar?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  'Keluar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildResultScreen() {
    final percentage = (score / questions.length * 100).round();
    String resultMessage;
    Color resultColor;
    IconData resultIcon;

    if (percentage >= 80) {
      resultMessage = "Excellent! Pemahaman Anda sangat baik!";
      resultColor = Colors.green;
      resultIcon = Icons.emoji_events;
    } else if (percentage >= 60) {
      resultMessage = "Good! Pemahaman Anda cukup baik!";
      resultColor = Colors.orange;
      resultIcon = Icons.thumb_up;
    } else {
      resultMessage = "Perlu belajar lebih giat lagi!";
      resultColor = Colors.red;
      resultIcon = Icons.refresh;
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Hasil Quiz'),
        backgroundColor: Color.fromARGB(255, 218, 4, 11),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: resultColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(resultIcon, size: 60, color: resultColor),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Quiz Selesai!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: resultColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          resultMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildScoreItem(
                              'Skor Anda',
                              '$score/${questions.length}',
                              Icons.score,
                              Colors.blue,
                            ),
                            _buildScoreItem(
                              'Persentase',
                              '$percentage%',
                              Icons.percent,
                              resultColor,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Detail Quiz:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[700],
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildDetailRow('Kategori', widget.category),
                              _buildDetailRow('Tingkat', widget.difficulty),
                              _buildDetailRow(
                                'Jumlah Soal',
                                '${questions.length}',
                              ),
                              if (widget.chapters != null)
                                _buildDetailRow(
                                  'Bab',
                                  widget.chapters!.join(', '),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _restartQuiz,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Ulangi Quiz'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 218, 4, 11),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.home),
                    label: const Text('Kembali ke Menu'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _restartQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      selectedAnswer = null;
      score = 0;
      isAnswered = false;
      isQuizCompleted = false;
      remainingTime = widget.duration * 60;
      _initializeQuiz();
    });
  }
}

import 'package:flutter/material.dart';

class FlashCardScreen extends StatefulWidget {
  const FlashCardScreen({super.key});

  @override
  State<FlashCardScreen> createState() => _FlashCardScreenState();
}

class _FlashCardScreenState extends State<FlashCardScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _flipAnimation;
  bool _isFlipped = false;
  int _currentIndex = 0;

  final List<Map<String, String>> flashCards = [
    {
      'front': 'Apa itu Flutter?',
      'back':
          'Flutter adalah framework UI toolkit dari Google untuk membangun aplikasi mobile, web, dan desktop dari satu codebase.',
    },
    {
      'front': 'Apa itu Widget dalam Flutter?',
      'back':
          'Widget adalah building block dasar dalam Flutter. Segala sesuatu dalam Flutter adalah widget, termasuk layout, text, button, dll.',
    },
    {
      'front': 'Apa perbedaan StatelessWidget dan StatefulWidget?',
      'back':
          'StatelessWidget tidak dapat berubah setelah dibuat, sedangkan StatefulWidget dapat berubah-ubah sesuai state internal.',
    },
    {
      'front': 'Apa itu Hot Reload?',
      'back':
          'Hot Reload adalah fitur Flutter yang memungkinkan developer melihat perubahan kode secara real-time tanpa restart aplikasi.',
    },
    {
      'front': 'Apa itu Dart?',
      'back':
          'Dart adalah bahasa pemrograman yang dikembangkan Google dan digunakan untuk membangun aplikasi Flutter.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (!_isFlipped) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  void _nextCard() {
    if (_currentIndex < flashCards.length - 1) {
      setState(() {
        _currentIndex++;
        _isFlipped = false;
      });
      _animationController.reset();
    }
  }

  void _previousCard() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _isFlipped = false;
      });
      _animationController.reset();
    }
  }

  void _resetCards() {
    setState(() {
      _currentIndex = 0;
      _isFlipped = false;
    });
    _animationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Flash Cards",
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
                colors: [Colors.purple, Color(0xFF9C27B0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Progress indicator
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Kartu ${_currentIndex + 1} dari ${flashCards.length}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.purple,
                        ),
                      ),
                      IconButton(
                        onPressed: _resetCards,
                        icon: const Icon(Icons.refresh, color: Colors.purple),
                        tooltip: "Reset ke awal",
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (_currentIndex + 1) / flashCards.length,
                    backgroundColor: Colors.purple[100],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.purple,
                    ),
                  ),
                ],
              ),
            ),

            // Flash Card
            Expanded(
              child: Center(
                child: GestureDetector(
                  onTap: _flipCard,
                  child: AnimatedBuilder(
                    animation: _flipAnimation,
                    builder: (context, child) {
                      final isShowingFront = _flipAnimation.value < 0.5;
                      return Transform(
                        alignment: Alignment.center,
                        transform:
                            Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..rotateY(_flipAnimation.value * 3.14159),
                        child: Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                            gradient: LinearGradient(
                              colors:
                                  isShowingFront
                                      ? [Colors.purple[50]!, Colors.white]
                                      : [
                                        Colors.purple[100]!,
                                        Colors.purple[50]!,
                                      ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  isShowingFront
                                      ? Icons.help_outline
                                      : Icons.lightbulb_outline,
                                  color: Colors.purple,
                                  size: 40,
                                ),
                                const SizedBox(height: 20),
                                Transform(
                                  alignment: Alignment.center,
                                  transform:
                                      Matrix4.identity()
                                        ..rotateY(isShowingFront ? 0 : 3.14159),
                                  child: Text(
                                    isShowingFront
                                        ? flashCards[_currentIndex]['front']!
                                        : flashCards[_currentIndex]['back']!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[800],
                                      height: 1.4,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  isShowingFront
                                      ? "Ketuk untuk melihat jawaban"
                                      : "Ketuk untuk melihat pertanyaan",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Navigation buttons
            // Navigation buttons
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _currentIndex > 0 ? _previousCard : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[600],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ), // jangan horizontal
                      ),
                      icon: const Icon(Icons.arrow_back, size: 20),
                      label: const Text("Sebelumnya"),
                    ),
                  ),
                  const SizedBox(width: 8), // jarak antar tombol
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _flipCard,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(Icons.flip, size: 20),
                      label: const Text("Balik"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed:
                          _currentIndex < flashCards.length - 1
                              ? _nextCard
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[700],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(Icons.arrow_forward, size: 20),
                      label: const Text("Selanjutnya"),
                    ),
                  ),
                ],
              ),
            ),

            // Study statistics
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple[200]!),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                    "Total Kartu",
                    "${flashCards.length}",
                    Icons.credit_card,
                  ),
                  Container(height: 30, width: 1, color: Colors.purple[200]),
                  _buildStatItem(
                    "Dipelajari",
                    "${_currentIndex + 1}",
                    Icons.done,
                  ),
                  Container(height: 30, width: 1, color: Colors.purple[200]),
                  _buildStatItem(
                    "Tersisa",
                    "${flashCards.length - _currentIndex - 1}",
                    Icons.schedule,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.purple, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class SoalScreen extends StatefulWidget {
  const SoalScreen({super.key});

  @override
  State<SoalScreen> createState() => _SoalScreenState();
}

class _SoalScreenState extends State<SoalScreen> {
  final List<Map<String, dynamic>> quizCategories = [
    {
      'title': 'Quiz Dasar',
      'description': '10 soal pilihan ganda tingkat dasar',
      'questionCount': 10,
      'difficulty': 'Mudah',
      'icon': Icons.lightbulb_outline,
      'color': Colors.green,
      'duration': '15 menit',
    },
    {
      'title': 'Quiz Menengah',
      'description': '15 soal pilihan ganda tingkat menengah',
      'questionCount': 15,
      'difficulty': 'Sedang',
      'icon': Icons.psychology,
      'color': Colors.orange,
      'duration': '25 menit',
    },
    {
      'title': 'Quiz Lanjutan',
      'description': '20 soal pilihan ganda tingkat lanjut',
      'questionCount': 20,
      'difficulty': 'Sulit',
      'icon': Icons.emoji_events,
      'color': Colors.red,
      'duration': '35 menit',
    },
    {
      'title': 'Quiz Komprehensif',
      'description': '50 soal campuran semua tingkat',
      'questionCount': 50,
      'difficulty': 'Campuran',
      'icon': Icons.star,
      'color': Colors.purple,
      'duration': '60 menit',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Latihan Soal",
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
                colors: [Colors.orange, Color(0xFFFF9800)],
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[50]!, Colors.blue[100]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue, size: 24),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Pilih kategori soal yang ingin Anda kerjakan untuk mengasah kemampuan!",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Kategori Soal",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 500, // maksimal lebar card
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 0,
                  childAspectRatio: 3, // lebih fleksibel
                ),
                itemCount: quizCategories.length,
                itemBuilder: (context, index) {
                  final category = quizCategories[index];
                  return _buildQuizCard(category);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizCard(Map<String, dynamic> category) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _startQuiz(category),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: category['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  category['icon'],
                  color: category['color'],
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category['description'],
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                      maxLines: 2, // batasi jadi 2 baris
                      overflow:
                          TextOverflow
                              .ellipsis, // kalau terlalu panjang, jadi "..."
                    ),

                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildInfoChip(
                          Icons.quiz,
                          '${category['questionCount']} Soal',
                          category['color'],
                        ),
                        const SizedBox(width: 8),
                        _buildInfoChip(
                          Icons.schedule,
                          category['duration'],
                          category['color'],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: category['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  category['difficulty'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: category['color'],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _startQuiz(Map<String, dynamic> category) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Memulai ${category['title']}"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Jumlah Soal: ${category['questionCount']}"),
                Text("Durasi: ${category['duration']}"),
                Text("Tingkat: ${category['difficulty']}"),
                const SizedBox(height: 16),
                const Text(
                  "Pastikan koneksi internet stabil dan siapkan waktu yang cukup.",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Implement quiz start logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Memulai ${category['title']}..."),
                    backgroundColor: category['color'],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: category['color'],
                foregroundColor: Colors.white,
              ),
              child: const Text("Mulai"),
            ),
          ],
        );
      },
    );
  }
}

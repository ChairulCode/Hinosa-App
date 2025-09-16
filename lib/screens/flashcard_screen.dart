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
    // Bagian Pertama - Serangan dan Invasi
    {
      'front': 'Kapan Jepang menyerang Pearl Harbor?',
      'back': '7 Desember 1941',
    },
    {
      'front': 'Siapa pemimpin serangan Pearl Harbor?',
      'back': 'Laksamana Noichi Nagumo atas perintah Yamamoto',
    },
    {
      'front': 'Apa tujuan serangan Pearl Harbor?',
      'back':
          'Menghancurkan Armada Pasifik AS agar leluasa menguasai Asia Tenggara',
    },
    {'front': 'Kapan Jepang mendarat di Tarakan?', 'back': '11 Januari 1942'},
    {
      'front': 'Kota minyak yang jatuh setelah Tarakan?',
      'back': 'Balikpapan (24 Januari 1942)',
    },
    {
      'front': 'Pertempuran laut penting sebelum jatuhnya Jawa?',
      'back': 'Pertempuran Laut Jawa (27 Februari 1942) dipimpin Karel Doorman',
    },
    {
      'front': 'Kapan Belanda menyerah tanpa syarat pada Jepang?',
      'back': '8 Maret 1942 di Kalijati',
    },

    // Bagian Kedua - Sistem Pemerintahan
    {
      'front': 'Apa nama aturan dasar pemerintahan sementara Jepang?',
      'back': 'Osamu Seirei (7 Maret 1942)',
    },
    {
      'front': 'Siapa panglima pertama Tentara ke-16 di Jawa?',
      'back': 'Letnan Jenderal Hitoshi Imamura',
    },
    {
      'front': 'Apa fungsi Gunseikan?',
      'back': 'Kepala pemerintahan militer Jepang di Jawa',
    },
    {
      'front': 'Departemen apa saja di bawah Gunseikanbu?',
      'back':
          'Somubu (Umum), Zaimubu (Keuangan), Sangyobu (Industri), Kotsubu (Lalu lintas), Shihobu (Kehakiman)',
    },
    {
      'front': 'Kota istimewa (koci) pada masa Jepang?',
      'back': 'Surakarta dan Yogyakarta',
    },
    {
      'front': 'Siapa residen Indonesia pertama yang diangkat Jepang?',
      'back': 'R.A.A. Wiranatakusumah (Priangan)',
    },
    {
      'front': 'Lagu kebangsaan yang wajib dipakai masa Jepang?',
      'back': 'Kimigayo (Jepang)',
    },

    // Bagian Ketiga - Struktur Administratif
    {
      'front': 'Undang-Undang No. 27 tahun 1942 mengatur apa?',
      'back': 'Perubahan tata pemerintahan daerah di Jawa-Madura',
    },
    {'front': 'Apa arti Syu?', 'back': 'Setara keresidenan, dipimpin Syucokan'},
    {
      'front': 'Apa arti Syi, Ken, Gun, Son, Ku?',
      'back':
          'Syi = kotapraja, Ken = kabupaten, Gun = kewedanan, Son = kecamatan, Ku = desa',
    },
    {
      'front': 'Berapa jumlah syu di Jawa?',
      'back': '17 syu (contoh: Batavia, Priangan, Surabaya)',
    },
    {
      'front': 'Apa fungsi Cokan Kanbo?',
      'back':
          'Majelis penasehat syucokan, terdiri atas 3 bu: Naiseibu, Keizaibu, Keisatsubu',
    },
    {
      'front': 'Apa itu Tokubetsu Syi?',
      'back': 'Kotapraja istimewa, contohnya Batavia',
    },
    {
      'front': 'Apa badan pertimbangan pusat Jepang di Indonesia?',
      'back': 'Chuo Sangi In (dibentuk 1943)',
    },

    // Bagian Keempat - Sikap Tokoh Nasional
    {
      'front': 'Tokoh nasional yang bekerja sama dengan Jepang?',
      'back': 'Soekarno, Hatta, Ki Hajar Dewantara, K.H. Mas Mansur',
    },
    {
      'front': 'Tokoh yang menolak kerja sama dengan Jepang?',
      'back': 'Sutan Sjahrir, Dr. Tjipto Mangunkusumo',
    },
    {
      'front': 'Apa alasan Soekarno-Hatta bekerja sama?',
      'back': 'Memanfaatkan Jepang demi cita-cita kemerdekaan',
    },
    {
      'front': 'Apa sikap Sjahrir terhadap Jepang?',
      'back': 'Nonkooperatif, membangun jaringan bawah tanah',
    },
    {
      'front': 'Apa sikap Dr. Tjipto terhadap Jepang?',
      'back': 'Anti-Jepang, mengimbau rakyat tetap mendukung Belanda sementara',
    },
    {
      'front': 'Mengapa rakyat awalnya simpati kepada Jepang?',
      'back': 'Karena ramalan Joyoboyo dan kebijakan Belanda yang keras kepala',
    },

    // Bagian Kelima - Organisasi Propaganda
    {
      'front': 'Organisasi propaganda pertama Jepang?',
      'back': 'Gerakan Tiga A (1942)',
    },
    {'front': 'Siapa tokoh utama Gerakan Tiga A?', 'back': 'Mr. Samsudin'},
    {
      'front': 'Organisasi pengganti Tiga A?',
      'back': 'Poetera (Poesat Tenaga Rakjat)',
    },
    {
      'front': 'Siapa pimpinan Poetera?',
      'back':
          'Empat Serangkai: Soekarno, Hatta, Ki Hajar Dewantara, K.H. Mas Mansur',
    },
    {'front': 'Organisasi pengganti Poetera?', 'back': 'Jawa Hokokai (1944)'},
    {
      'front': 'Apa dasar semangat Jawa Hokokai?',
      'back': 'Hoko Seishin: pengorbanan diri, persaudaraan, kerja nyata',
    },
    {'front': 'Apa organisasi perempuan di bawah Jepang?', 'back': 'Fujinkai'},

    // Bagian Keenam - Persiapan Kemerdekaan
    {
      'front': 'Siapa yang mengumumkan janji kemerdekaan?',
      'back': 'PM Koiso (7 September 1944)',
    },
    {
      'front': 'Apa kepanjangan BPUPKI?',
      'back': 'Badan Penyelidik Usaha Persiapan Kemerdekaan Indonesia',
    },
    {'front': 'Kapan BPUPKI dibentuk?', 'back': '1 Maret 1945'},
    {'front': 'Siapa ketua BPUPKI?', 'back': 'Dr. Radjiman Wedyodiningrat'},
    {
      'front': 'Apa fungsi BPUPKI?',
      'back': 'Menyelidiki dasar-dasar bagi kemerdekaan Indonesia',
    },
    {
      'front': 'Apa organisasi pengganti BPUPKI?',
      'back': 'PPKI (Panitia Persiapan Kemerdekaan Indonesia)',
    },
    {'front': 'Kapan PPKI dibentuk?', 'back': '28 Juli 1945'},
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
            "Flash Cards Sejarah",
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
                          color: Color(0xFF6366F1),
                        ),
                      ),
                      IconButton(
                        onPressed: _resetCards,
                        icon: const Icon(
                          Icons.refresh,
                          color: Color(0xFF6366F1),
                        ),
                        tooltip: "Reset ke awal",
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (_currentIndex + 1) / flashCards.length,
                    backgroundColor: const Color(0xFF6366F1).withOpacity(0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF6366F1),
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
                                      ? [
                                        const Color(
                                          0xFF6366F1,
                                        ).withOpacity(0.1),
                                        Colors.white,
                                      ]
                                      : [
                                        const Color(
                                          0xFF8B5CF6,
                                        ).withOpacity(0.2),
                                        const Color(
                                          0xFF6366F1,
                                        ).withOpacity(0.1),
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
                                      ? Icons.quiz
                                      : Icons.lightbulb_outline,
                                  color: const Color(0xFF6366F1),
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
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(Icons.arrow_back, size: 20),
                      label: const Text("Sebelumnya"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _flipCard,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
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
                        backgroundColor: const Color(0xFF8B5CF6),
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
                color: const Color(0xFF6366F1).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF6366F1).withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                    "Total Kartu",
                    "${flashCards.length}",
                    Icons.credit_card,
                  ),
                  Container(
                    height: 30,
                    width: 1,
                    color: const Color(0xFF6366F1).withOpacity(0.3),
                  ),
                  _buildStatItem(
                    "Dipelajari",
                    "${_currentIndex + 1}",
                    Icons.done,
                  ),
                  Container(
                    height: 30,
                    width: 1,
                    color: const Color(0xFF6366F1).withOpacity(0.3),
                  ),
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
        Icon(icon, color: const Color(0xFF6366F1), size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6366F1),
          ),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}

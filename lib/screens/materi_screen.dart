import 'package:flutter/material.dart';
import 'package:hinosaapp/screens/materi_detail/pergerakan_screen.dart';
import 'package:hinosaapp/screens/materi_detail/pengerahan_screen.dart';
import 'package:hinosaapp/screens/materi_detail/drama_screen.dart';
import 'package:hinosaapp/screens/materi_detail/kedatangan_screen.dart';

class MateriScreen extends StatefulWidget {
  const MateriScreen({super.key});

  @override
  State<MateriScreen> createState() => _MateriScreenState();
}

class _MateriScreenState extends State<MateriScreen> {
  final List<Map<String, dynamic>> materiList = [
    {
      'title': 'Susunan dan Perkembangan Pemerintahan Pendudukan Jepang',
      'subtitle': 'Materi pengenalan konsep dasar',
      'icon': Icons.school,
      'color': Colors.blue,
      'progress': 0.0,
      'id': 'kedatangan_jepang',
      'widget': const KedatanganJepangDetail(),
    },
    {
      'title': 'Pergerakan Indonesia dan jepang',
      'subtitle': 'Pembelajaran tingkat menengah',
      'icon': Icons.trending_up,
      'color': Colors.green,
      'progress': 0.0,
      'id': 'organisasi_pergerakan',
      'widget': const PergerakanScreenDetail(),
    },
    {
      'title': 'Pengerahan dan penindasan versus perlawanan',
      'subtitle': 'Penerapan dalam kehidupan nyata',
      'icon': Icons.assignment,
      'color': Colors.orange,
      'progress': 0.0,
      'id': 'pengerahan_penindasan',
      'widget': const PengerahanPenindasanDetail(),
    },
    {
      'title': 'Drama akhir sang tirani',
      'subtitle': 'Penilaian pemahaman materi',
      'icon': Icons.assessment,
      'color': Colors.red,
      'progress': 0.0,
      'id': 'drama_akhir',
      'widget': const DramaAkhirDetail(),
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  void _loadProgress() {
    setState(() {
      materiList[0]['progress'] = 0.0;
      materiList[1]['progress'] = 0.0;
      materiList[2]['progress'] = 0.0;
      materiList[3]['progress'] = 0.0;
    });
  }

  void _updateProgress(String id, double progress) {
    setState(() {
      final index = materiList.indexWhere((item) => item['id'] == id);
      if (index != -1) {
        materiList[index]['progress'] = progress;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.blue,
            title: const Text(
              "Materi Pembelajaran",
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
                  colors: [Color(0xFFBB002C), Color(0xFFE53935)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
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
            const Center(
              child: Text(
                "Kependudukan Jepang di Indonesia",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: materiList.length,
                itemBuilder: (context, index) {
                  final materi = materiList[index];
                  return _buildMateriCard(materi);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMateriCard(Map<String, dynamic> materi) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => materi['widget']),
          );

          if (result != null && result is double) {
            _updateProgress(materi['id'], result);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: materi['color'].withOpacity(0.1),
                child: Icon(materi['icon'], color: materi['color'], size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      materi['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      materi['subtitle'],
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Progress: ${(materi['progress'] * 100).toInt()}%',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: materi['progress'],
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            materi['color'],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: materi['color'], size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

abstract class BaseMateriDetail extends StatefulWidget {
  const BaseMateriDetail({super.key});
}

abstract class BaseMateriDetailState<T extends BaseMateriDetail>
    extends State<T> {
  late ScrollController _scrollController;
  double _scrollProgress = 0.0;

  String get title;
  Color get color;
  List<Map<String, dynamic>> get sections;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_updateScrollProgress);
  }

  void _updateScrollProgress() {
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      setState(() {
        _scrollProgress =
            maxScroll > 0 ? (currentScroll / maxScroll).clamp(0.0, 1.0) : 0.0;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollProgress);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _scrollProgress);
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: AppBar(
              centerTitle: true,
              elevation: 0,
              title: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context, _scrollProgress),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Progress Baca: ${(_scrollProgress * 100).toInt()}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            _scrollProgress >= 1.0
                                ? '✓ Selesai'
                                : 'Sedang Membaca',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: _scrollProgress,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              ...sections.map<Widget>((section) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          section['title'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...section['content'].map<Widget>((point) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 6,
                                    right: 8,
                                  ),
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    point,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                );
              }).toList(),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    Icon(
                      _scrollProgress >= 1.0
                          ? Icons.check_circle
                          : Icons.info_outline,
                      color: color,
                      size: 30,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _scrollProgress >= 1.0
                          ? 'Materi Selesai Dibaca!'
                          : 'Scroll ke bawah untuk melanjutkan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _scrollProgress >= 1.0
                          ? 'Anda telah menyelesaikan materi ini'
                          : 'Progress membaca akan tersimpan otomatis',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// // kedatangan_jepang_detail.dart
// class KedatanganJepangDetail extends BaseMateriDetail {
//   const KedatanganJepangDetail({super.key});

//   @override
//   State<KedatanganJepangDetail> createState() => _KedatanganJepangDetailState();
// }

// class _KedatanganJepangDetailState
//     extends BaseMateriDetailState<KedatanganJepangDetail> {
//   @override
//   String get title => 'Kedatangan Jepang di Indonesia';

//   @override
//   Color get color => Colors.blue;

//   @override
//   List<Map<String, dynamic>> get sections => [
//     {
//       'title': '1. Masuknya Jepang di Indonesia',
//       'content': [
//         'Pada 8 Desember 1941, Jepang melancarkan serangan besar-besaran ke Pearl Harbor, markas Angkatan Laut Amerika Serikat di Pasifik.',
//         'Target berikutnya adalah Indonesia (Hindia Belanda) karena kaya sumber daya alam: minyak bumi, timah, dan aluminium.',
//         'Awal Januari 1942, pasukan Jepang mendarat di Ambon, menguasai Maluku, lalu merebut Tarakan dan Balikpapan (12 Januari).',
//         'Pada 5 Maret 1942: Batavia (Jakarta) direbut Jepang',
//         '8 Maret 1942: Belanda menyerah tanpa syarat dalam Kapitulasi Kalijati, Subang',
//       ],
//     },
//     {
//       'title': '2. Sambutan Rakyat Indonesia',
//       'content': [
//         'Rakyat Indonesia menyambut Jepang dengan gembira sebagai "Saudara Tua"',
//         'Antusiasme dipengaruhi oleh kebencian terhadap Belanda dan ramalan Jayabaya',
//         'Jepang mengusung slogan Hakko Ichiu "Satu Keluarga di Bawah Langit"',
//         'Membentuk Gerakan Tiga A dengan slogan: Nippon Cahaya Asia, Nippon Pelindung Asia, Nippon Pemimpin Asia',
//       ],
//     },
//   ];
// }

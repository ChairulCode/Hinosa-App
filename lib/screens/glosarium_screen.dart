import 'package:flutter/material.dart';

class GlosariumScreen extends StatefulWidget {
  const GlosariumScreen({super.key});

  @override
  State<GlosariumScreen> createState() => _GlosariumScreenState();
}

class _GlosariumScreenState extends State<GlosariumScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'Semua';

  final List<String> categories = [
    'Semua',
    'Pendudukan Jepang',
    'Organisasi',
    'Militer Jepang',
    'Tokoh Nasional',
    'Lainnya',
  ];

  final List<Map<String, String>> glosariumData = [
    {
      'term': 'Asia Raya',
      'definition':
          'Konsep propaganda Jepang untuk menyatukan bangsa Asia di bawah pimpinan Jepang.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Barisan Pelopor',
      'definition':
          'Organisasi semi-militer yang dibentuk pada tahun 1944 di bawah naungan Jawa Hokokai.',
      'category': 'Organisasi',
    },
    {
      'term': 'Barisan Propaganda Asia Raya',
      'definition':
          'Organisasi yang dibentuk Jepang untuk menyebarkan propaganda tentang "Kemakmuran Bersama Asia Timur Raya".',
      'category': 'Organisasi',
    },
    {
      'term': 'Beppan',
      'definition':
          'Kantor Rahasia (Bagian Intelijen). Lembaga rahasia bentukan pemerintahan militer Jepang di Indonesia yang menangani urusan intelijen, penyelidikan, dan pengawasan politik.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Boei Engokai',
      'definition':
          'Organisasi yang membantu prajurit PETA dan Heiho, terutama dalam urusan sosial-ekonomi.',
      'category': 'Organisasi',
    },
    {
      'term': 'Budancho',
      'definition':
          'Komandan regu. Pangkat terendah dalam struktur kepemimpinan militer PETA (Pembela Tanah Air).',
      'category': 'Militer Jepang',
    },
    {
      'term': 'BPUPKI',
      'definition':
          'Badan Penyelidik Usaha-usaha Persiapan Kemerdekaan Indonesia. Dibentuk oleh Jepang tahun 1945 untuk merancang dasar negara dan konstitusi Indonesia.',
      'category': 'Organisasi',
    },
    {
      'term': 'Bogodan',
      'definition':
          'Barisan Pertahanan Desa. Organisasi semi-militer bentukan Jepang yang beranggotakan rakyat desa.',
      'category': 'Organisasi',
    },
    {
      'term': 'Chuo Sangi In',
      'definition':
          'Dewan pertimbangan pusat. Badan penasihat yang dibentuk Jepang pada tahun 1943 untuk menarik simpati tokoh bangsa Indonesia.',
      'category': 'Organisasi',
    },
    {
      'term': 'Chōkan (Gunseikan)',
      'definition': 'Kepala pemerintahan militer Jepang di Indonesia.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Cudancho (Chudanco)',
      'definition':
          'Komandan Kompi. Salah satu tingkat kepemimpinan dalam organisasi militer PETA.',
      'category': 'Militer Jepang',
    },
    {
      'term': 'Cuo Seinen Kunrensyo',
      'definition':
          'Pusat Latihan Pemuda. Lembaga pelatihan kepemudaan yang didirikan Jepang di tingkat pusat maupun daerah.',
      'category': 'Organisasi',
    },
    {
      'term': 'Daidan',
      'definition':
          'Satuan militer Jepang berisi pemuda Indonesia untuk latihan militer.',
      'category': 'Militer Jepang',
    },
    {
      'term': 'Daidancho',
      'definition':
          'Komandan Batalyon. Pangkat tertinggi dalam organisasi militer bentukan Jepang di Indonesia, terutama PETA.',
      'category': 'Militer Jepang',
    },
    {
      'term': 'Dai Nippon',
      'definition': 'Kekaisaran Jepang Raya.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Dōmei Tsūshinsha',
      'definition': 'Kantor berita Jepang yang beroperasi di Indonesia.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Dokuritsu Junbi Cosokai',
      'definition':
          'Badan Penyelidik Usaha-usaha Persiapan Kemerdekaan Indonesia (BPUPKI). Dibentuk pada 1 Maret 1945.',
      'category': 'Organisasi',
    },
    {
      'term': 'Dokuritsu Junbi Inkai',
      'definition':
          'Panitia Persiapan Kemerdekaan Indonesia (PPKI). Dibentuk 7 Agustus 1945 sebagai kelanjutan dari BPUPKI.',
      'category': 'Organisasi',
    },
    {
      'term': 'Empat Serangkai',
      'definition':
          'Soekarno, Moh. Hatta, Ki Hadjar Dewantara, dan K.H. Mas Mansur, tokoh nasionalis simbol kerja sama dengan Jepang.',
      'category': 'Tokoh Nasional',
    },
    {
      'term': 'Fujinkai',
      'definition':
          'Perhimpunan Wanita. Organisasi wanita bentukan Jepang untuk perempuan usia 15 tahun ke atas.',
      'category': 'Organisasi',
    },
    {
      'term': 'Gakutotai',
      'definition':
          'Barisan Siswa. Organisasi bentukan Jepang yang mewajibkan siswa sekolah menengah ikut kegiatan semi-militer.',
      'category': 'Organisasi',
    },
    {
      'term': 'GAPI',
      'definition':
          'Gabungan Politik Indonesia. Gabungan organisasi politik nasionalis (1939) yang menuntut Indonesia berparlemen.',
      'category': 'Organisasi',
    },
    {
      'term': 'Gerakan Tiga A',
      'definition': 'Propaganda awal Jepang (1942).',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Giyūgun',
      'definition': 'Pasukan sukarela di daerah pendudukan Jepang.',
      'category': 'Militer Jepang',
    },
    {
      'term': 'Giyuhei',
      'definition':
          'Tentara Sukarela. Pasukan sukarela dari kalangan rakyat Indonesia untuk membantu kepentingan perang Jepang.',
      'category': 'Militer Jepang',
    },
    {
      'term': 'Gunsei',
      'definition':
          'Administrasi militer Jepang yang dijalankan di Indonesia selama pendudukan.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Gunseikan',
      'definition':
          'Kepala pemerintahan militer Jepang di wilayah pendudukan dengan wewenang penuh.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Gunseikanbu',
      'definition': 'Pemerintahan militer Jepang di Jawa.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Hakko Ichiu',
      'definition':
          'Semboyan Jepang yang berarti “Dunia di bawah satu atap”. Ideologi propaganda Jepang.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Heiho',
      'definition':
          'Prajurit pembantu ketentaraan Jepang dari kalangan pemuda Indonesia.',
      'category': 'Militer Jepang',
    },
    {
      'term': 'Hinomaru',
      'definition': 'Bendera Jepang dengan lingkaran merah di tengah.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Hizbullah',
      'definition':
          'Tentara Allah. Organisasi militer Islam bentukan Jepang tahun 1944 di bawah koordinasi Masyumi.',
      'category': 'Organisasi',
    },
    {
      'term': 'Jawa Hokokai',
      'definition': 'Asosiasi Kebaktian Jawa (1944).',
      'category': 'Organisasi',
    },
    {
      'term': 'Jibakutai',
      'definition':
          'Pasukan berani mati. Kesatuan khusus yang dibentuk Jepang tahun 1945 dari pemuda Indonesia.',
      'category': 'Militer Jepang',
    },
    {
      'term': 'Josyi Seinendan',
      'definition':
          'Barisan Pemuda Putri. Organisasi semi-militer bentukan Jepang untuk gadis usia 14–25 tahun.',
      'category': 'Organisasi',
    },
    {
      'term': 'Jugun ianfu',
      'definition':
          'Perempuan yang dipaksa oleh militer Jepang untuk menjadi budak seks bagi tentara Jepang pada masa Perang Dunia II.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Kaigun',
      'definition': 'Angkatan Laut Jepang yang menduduki wilayah Indonesia.',
      'category': 'Militer Jepang',
    },
    {
      'term': 'Keimubu',
      'definition':
          'Departemen Dalam Negeri (Bagian Keamanan). Mengurus masalah keamanan dan pengawasan politik masyarakat.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Kayo Keibotai',
      'definition':
          'Organisasi bentukan Jepang beranggotakan pemuda Indonesia untuk membantu tugas polisi Jepang.',
      'category': 'Organisasi',
    },
    {
      'term': 'Keibōdan',
      'definition': 'Barisan pembantu polisi bentukan Jepang.',
      'category': 'Organisasi',
    },
    {
      'term': 'Keibōtai',
      'definition': 'Satuan polisi lokal bentukan Jepang.',
      'category': 'Organisasi',
    },
    {
      'term': 'Keimin Bunka Shidosho',
      'definition':
          'Lembaga kebudayaan yang dibentuk Jepang di Jakarta tahun 1943.',
      'category': 'Organisasi',
    },
    {
      'term': 'Kempeitai',
      'definition': 'Polisi militer Jepang yang terkenal keras.',
      'category': 'Militer Jepang',
    },
    {
      'term': 'Keisatsubu',
      'definition': 'Departemen Kepolisian Jepang di Indonesia.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Kinrō Hōshi',
      'definition': 'Kerja bakti wajib untuk rakyat.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Koa Kunrenjo',
      'definition': 'Lembaga pendidikan Jepang untuk melatih calon pemimpin.',
      'category': 'Organisasi',
    },
    {
      'term': 'Kumiai',
      'definition':
          'Perhimpunan/Koperasi ekonomi bentukan Jepang di pedesaan yang mewajibkan petani bergabung.',
      'category': 'Organisasi',
    },
    {
      'term': 'Kuōmintō',
      'definition':
          'Partai politik Tiongkok, disebut dalam konteks Perang Asia Timur Raya.',
      'category': 'Lainnya',
    },
    {
      'term': 'Masyumi',
      'definition':
          'Organisasi politik Islam dibentuk Jepang 24 Oktober 1943 sebagai wadah persatuan umat Islam menggantikan MIAI.',
      'category': 'Organisasi',
    },
    {
      'term': 'MIAI',
      'definition':
          'Majelis Islam A’la Indonesia. Organisasi gabungan Islam didirikan 1937, dibubarkan Jepang tahun 1943.',
      'category': 'Organisasi',
    },
    {
      'term': 'Minseifu',
      'definition':
          'Pemerintahan sipil yang dibentuk Jepang di Indonesia pada masa pendudukan.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Mohammad Hatta',
      'definition': 'Pemimpin pergerakan nasional, proklamator RI.',
      'category': 'Tokoh Nasional',
    },
    {
      'term': 'Naimubu Bunkyoku',
      'definition':
          'Kantor Departemen Pendidikan bentukan pemerintahan militer Jepang di Indonesia.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Nippon Seishin/Nipponisasi',
      'definition':
          'Semangat Jepang yang ditanamkan lewat pendidikan dan propaganda.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Osamu Seirei',
      'definition':
          'Undang-undang/peraturan yang dikeluarkan pemerintahan militer Jepang di Indonesia.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'PETA',
      'definition':
          'Pembela Tanah Air. Tentara sukarela bentukan Jepang (1943).',
      'category': 'Militer Jepang',
    },
    {
      'term': 'Petisi Soetardjo',
      'definition':
          'Permintaan tahun 1938 agar diadakan konferensi Indonesia-Belanda tentang pemerintahan sendiri. Ditolak Belanda.',
      'category': 'Lainnya',
    },
    {
      'term': 'Pendudukan Jepang',
      'definition':
          'Masa ketika Jepang menguasai Indonesia setelah Belanda menyerah (1942–1945).',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Propaganda Jepang',
      'definition': 'Upaya membangun citra Jepang sebagai “Saudara Tua”.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'PUTERA',
      'definition':
          'Pusat Tenaga Rakyat. Organisasi massa bentukan Jepang (1943).',
      'category': 'Organisasi',
    },
    {
      'term': 'Rikugun',
      'definition':
          'Angkatan Darat Jepang yang menduduki sebagian besar wilayah Indonesia.',
      'category': 'Militer Jepang',
    },
    {
      'term': 'Romusha',
      'definition': 'Sistem kerja paksa oleh Jepang.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Romukyokai',
      'definition':
          'Organisasi untuk merekrut dan mengawasi tenaga kerja romusha demi kepentingan Jepang.',
      'category': 'Organisasi',
    },
    {
      'term': 'Saiko Shikikan',
      'definition': 'Panglima tertinggi militer Jepang di Asia Tenggara.',
      'category': 'Militer Jepang',
    },
    {
      'term': 'San A Seinen Kunrensho',
      'definition':
          'Pusat Latihan Pemuda Tiga A. Lembaga pendidikan kepemudaan bentukan Jepang.',
      'category': 'Organisasi',
    },
    {
      'term': 'Seinendan',
      'definition': 'Barisan pemuda usia 14–22 tahun bentukan Jepang.',
      'category': 'Organisasi',
    },
    {
      'term': 'Seinen Kurabu',
      'definition': 'Perkumpulan pemuda bentukan Jepang.',
      'category': 'Organisasi',
    },
    {
      'term': 'Seikerei',
      'definition': 'Membungkuk ke arah Tokyo sebagai penghormatan.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Sendenbu',
      'definition': 'Bagian Gunseikanbu yang khusus menangani propaganda.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Shintaisei',
      'definition': 'Tatanan Baru Asia Timur Raya, ideologi Jepang.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Shodancho',
      'definition': 'Komandan Peleton dalam organisasi militer PETA.',
      'category': 'Militer Jepang',
    },
    {
      'term': 'Shūchikan',
      'definition': 'Pusat pendidikan dan pelatihan militer Jepang.',
      'category': 'Militer Jepang',
    },
    {
      'term': 'Syucokan',
      'definition':
          'Kepala Pemerintahan Karesidenan (Residen) pada masa pendudukan Jepang.',
      'category': 'Pendudukan Jepang',
    },
    {
      'term': 'Syu Sangikai',
      'definition':
          'Dewan Pertimbangan di tingkat daerah (syu) yang melibatkan tokoh lokal.',
      'category': 'Organisasi',
    },
    {
      'term': 'Togyo Rengokai',
      'definition':
          'Gabungan perusahaan gula yang dibentuk pemerintah pendudukan Jepang di Indonesia.',
      'category': 'Organisasi',
    },
    {
      'term': 'Tonarigumi',
      'definition': 'Organisasi rukun tetangga buatan Jepang.',
      'category': 'Organisasi',
    },
    {
      'term': 'Wakaba',
      'definition': 'Sekolah kepandaian putri zaman Jepang.',
      'category': 'Organisasi',
    },
  ];

  List<Map<String, String>> get filteredGlosarium {
    return glosariumData.where((item) {
      final matchesSearch =
          item['term']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item['definition']!.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );

      final matchesCategory =
          _selectedCategory == 'Semua' || item['category'] == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
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
            "Glosarium Pendudukan Jepang",
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
              color: Color.fromARGB(255, 218, 4, 11),
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Cari istilah atau definisi...',
                      prefixIcon: Icon(Icons.search, color: Colors.blue),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = category == _selectedCategory;

                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                          backgroundColor: Colors.grey[200],
                          selectedColor: Colors.blue[100],
                          labelStyle: TextStyle(
                            color:
                                isSelected
                                    ? Colors.blue[800]
                                    : Colors.grey[700],
                            fontWeight:
                                isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color:
                                  isSelected ? Colors.blue : Colors.grey[300]!,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Results Count
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Text(
                  'Ditemukan ${filteredGlosarium.length} istilah',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),

          // Glosarium List
          Expanded(
            child:
                filteredGlosarium.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredGlosarium.length,
                      itemBuilder: (context, index) {
                        final item = filteredGlosarium[index];
                        return _buildGlosariumCard(item);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlosariumCard(Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getCategoryColor(item['category']!).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                item['category']!,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: _getCategoryColor(item['category']!),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item['term']!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Definisi:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item['definition']!,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        _showDetailDialog(item);
                      },
                      icon: const Icon(Icons.open_in_full, size: 16),
                      label: const Text('Lihat Detail'),
                      style: TextButton.styleFrom(foregroundColor: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Tidak ada istilah ditemukan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Coba gunakan kata kunci lain atau ubah filter kategori',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _searchController.clear();
                _searchQuery = '';
                _selectedCategory = 'Semua';
              });
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Reset Filter'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Pendudukan Jepang':
        return Colors.blue;
      case 'Organisasi':
        return Colors.green;
      case 'Militer Jepang':
        return Colors.red;
      case 'Tokoh Nasional':
        return Colors.orange;
      case 'Lainnya':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  void _showDetailDialog(Map<String, String> item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getCategoryColor(item['category']!).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item['category']!,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: _getCategoryColor(item['category']!),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item['term']!,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Text(
              item['definition']!,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

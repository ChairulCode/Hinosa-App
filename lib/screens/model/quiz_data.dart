// models/quiz_data.dart
class QuizQuestion2 {
  final String id;
  final String chapter;
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String explanation;

  QuizQuestion2({
    required this.id,
    required this.chapter,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });
}

class QuizData {
  static final List<QuizQuestion2> allQuestions = [
    // Administrasi Pemerintahan - Basic Level
    QuizQuestion2(
      id: 'A1',
      chapter: 'Administrasi Pemerintahan',
      question: 'Siapa yang memimpin pemerintahan militer Jepang di Jawa?',
      options: ['Gunseikan', 'Osamu Seirei', 'Kaico', 'Somubuco'],
      correctAnswer: 'Gunseikan',
      explanation:
          'Gunseikan adalah pemimpin pemerintahan militer Jepang di Jawa',
    ),
    QuizQuestion2(
      id: 'A2',
      chapter: 'Administrasi Pemerintahan',
      question: 'Apa fungsi Osamu Seirei dalam pemerintahan Jepang?',
      options: [
        'Peraturan militer',
        'Organisasi pemuda',
        'Lagu kebangsaan',
        'Perdagangan gula',
      ],
      correctAnswer: 'Peraturan militer',
      explanation:
          'Osamu Seirei berfungsi sebagai peraturan militer dalam pemerintahan Jepang',
    ),
    QuizQuestion2(
      id: 'A3',
      chapter: 'Administrasi Pemerintahan',
      question: 'Tonarigumi adalah organisasi di tingkat...',
      options: ['Kecamatan', 'Desa', 'RT/RW', 'Sekolah'],
      correctAnswer: 'RT/RW',
      explanation: 'Tonarigumi adalah organisasi di tingkat RT/RW',
    ),
    QuizQuestion2(
      id: 'A4',
      chapter: 'Administrasi Pemerintahan',
      question: 'Romukyokai merupakan organisasi untuk bidang...',
      options: ['Kebudayaan', 'Ekonomi', 'Transportasi', 'Agama'],
      correctAnswer: 'Transportasi',
      explanation:
          'Romukyokai adalah organisasi yang bergerak di bidang transportasi',
    ),
    QuizQuestion2(
      id: 'A5',
      chapter: 'Administrasi Pemerintahan',
      question: 'Keimin Bunka Shidosho bergerak dalam bidang...',
      options: ['Ekonomi', 'Budaya', 'Militer', 'Kesehatan'],
      correctAnswer: 'Budaya',
      explanation: 'Keimin Bunka Shidosho bergerak dalam bidang kebudayaan',
    ),

    // Organisasi dan Kehidupan Sosial - Basic Level
    QuizQuestion2(
      id: 'B1',
      chapter: 'Organisasi dan Kehidupan Sosial',
      question: 'Jugun Ianfu adalah...',
      options: [
        'Tentara sukarela',
        'Wanita penghibur',
        'Guru Jepang',
        'Petani',
      ],
      correctAnswer: 'Wanita penghibur',
      explanation:
          'Jugun Ianfu adalah wanita penghibur pada masa penjajahan Jepang',
    ),
    QuizQuestion2(
      id: 'B2',
      chapter: 'Organisasi dan Kehidupan Sosial',
      question: 'Fujinkai adalah organisasi untuk...',
      options: ['Pemuda', 'Wanita', 'Tentara', 'Pelajar'],
      correctAnswer: 'Wanita',
      explanation: 'Fujinkai adalah organisasi khusus untuk wanita',
    ),
    QuizQuestion2(
      id: 'B3',
      chapter: 'Organisasi dan Kehidupan Sosial',
      question: 'San A Seinen Kunrensyo adalah tempat pelatihan untuk...',
      options: ['Pemuda', 'Petani', 'Guru', 'Dokter'],
      correctAnswer: 'Pemuda',
      explanation:
          'San A Seinen Kunrensyo adalah tempat pelatihan khusus untuk pemuda',
    ),
    QuizQuestion2(
      id: 'B4',
      chapter: 'Organisasi dan Kehidupan Sosial',
      question: 'Hizbullah adalah organisasi...',
      options: ['Pemuda Kristen', 'Pemuda Islam', 'Tentara Jepang', 'Romusha'],
      correctAnswer: 'Pemuda Islam',
      explanation: 'Hizbullah adalah organisasi pemuda Islam pada masa itu',
    ),
    QuizQuestion2(
      id: 'B5',
      chapter: 'Organisasi dan Kehidupan Sosial',
      question: 'Masyumi dibentuk sebagai organisasi...',
      options: ['Kebudayaan', 'Islam politik', 'Perkebunan', 'Pendidikan'],
      correctAnswer: 'Islam politik',
      explanation: 'Masyumi dibentuk sebagai organisasi Islam politik',
    ),

    // Romusha dan Mobilisasi Rakyat - Intermediate Level
    QuizQuestion2(
      id: 'C1',
      chapter: 'Romusha dan Mobilisasi Rakyat',
      question: 'Romusha adalah...',
      options: [
        'Kerja paksa',
        'Pelatihan militer',
        'Sekolah rakyat',
        'Perkebunan',
      ],
      correctAnswer: 'Kerja paksa',
      explanation:
          'Romusha adalah sistem kerja paksa pada masa penjajahan Jepang',
    ),
    QuizQuestion2(
      id: 'C2',
      chapter: 'Romusha dan Mobilisasi Rakyat',
      question: 'Kerja paksa romusha terutama digunakan untuk...',
      options: ['Pendidikan', 'Perang', 'Kesehatan', 'Pertanian'],
      correctAnswer: 'Perang',
      explanation:
          'Romusha terutama digunakan untuk mendukung keperluan perang Jepang',
    ),
    QuizQuestion2(
      id: 'C3',
      chapter: 'Romusha dan Mobilisasi Rakyat',
      question: 'Apa dampak utama romusha bagi rakyat?',
      options: [
        'Kesejahteraan meningkat',
        'Banyak korban jiwa',
        'Pendidikan gratis',
        'Tanah subur',
      ],
      correctAnswer: 'Banyak korban jiwa',
      explanation:
          'Dampak utama romusha adalah banyaknya korban jiwa akibat kerja paksa',
    ),
    QuizQuestion2(
      id: 'C4',
      chapter: 'Romusha dan Mobilisasi Rakyat',
      question: 'Romusha sering dikirim ke luar negeri, contohnya...',
      options: [
        'Malaysia dan Burma',
        'Australia dan India',
        'Cina dan Korea',
        'Filipina dan Vietnam',
      ],
      correctAnswer: 'Malaysia dan Burma',
      explanation:
          'Romusha sering dikirim ke Malaysia dan Burma untuk kerja paksa',
    ),
    QuizQuestion2(
      id: 'C5',
      chapter: 'Romusha dan Mobilisasi Rakyat',
      question: 'Romusha dilakukan oleh pemerintah Jepang untuk...',
      options: [
        'Membangun fasilitas perang',
        'Mendirikan sekolah',
        'Membuka lahan pertanian',
        'Membuat rumah ibadah',
      ],
      correctAnswer: 'Membangun fasilitas perang',
      explanation:
          'Romusha dilakukan untuk membangun berbagai fasilitas perang',
    ),

    // Ekonomi Perang - Intermediate Level
    QuizQuestion2(
      id: 'D1',
      chapter: 'Ekonomi Perang',
      question: 'Ekonomi perang Jepang di Indonesia ditujukan untuk...',
      options: [
        'Kemakmuran rakyat',
        'Kepentingan perang Jepang',
        'Pendidikan rakyat',
        'Kesehatan umum',
      ],
      correctAnswer: 'Kepentingan perang Jepang',
      explanation:
          'Ekonomi perang Jepang di Indonesia ditujukan untuk kepentingan perang mereka',
    ),
    QuizQuestion2(
      id: 'D2',
      chapter: 'Ekonomi Perang',
      question: 'Osamu Seirei No. 30/1944 berkaitan dengan...',
      options: [
        'Penghapusan SKK',
        'Pengangkatan Jugun Ianfu',
        'Pendirian Fujinkai',
        'Pembentukan PETA',
      ],
      correctAnswer: 'Penghapusan SKK',
      explanation: 'Osamu Seirei No. 30/1944 berkaitan dengan penghapusan SKK',
    ),
    QuizQuestion2(
      id: 'D3',
      chapter: 'Ekonomi Perang',
      question: 'Tanaman yang dianggap vital untuk perang adalah...',
      options: [
        'Kopi dan teh',
        'Karet dan kina',
        'Tembakau dan padi',
        'Jagung dan singkong',
      ],
      correctAnswer: 'Karet dan kina',
      explanation:
          'Karet dan kina dianggap sebagai tanaman vital untuk keperluan perang',
    ),
    QuizQuestion2(
      id: 'D4',
      chapter: 'Ekonomi Perang',
      question: 'Togyo Rengokai adalah organisasi dalam bidang...',
      options: ['Pendidikan', 'Perkebunan', 'Perusahaan gula', 'Transportasi'],
      correctAnswer: 'Perusahaan gula',
      explanation:
          'Togyo Rengokai adalah organisasi yang bergerak di bidang perusahaan gula',
    ),
    QuizQuestion2(
      id: 'D5',
      chapter: 'Ekonomi Perang',
      question: 'Jawa dibagi menjadi berapa lingkungan autarki?',
      options: ['10', '17', '7', '20'],
      correctAnswer: '17',
      explanation: 'Jawa dibagi menjadi 17 lingkungan autarki oleh Jepang',
    ),

    // Pendidikan, Komunikasi Sosial, dan Budaya - Intermediate Level
    QuizQuestion2(
      id: 'E1',
      chapter: 'Pendidikan, Komunikasi Sosial, dan Budaya',
      question: 'Jumlah sekolah dasar pada awal Jepang turun menjadi...',
      options: ['21.500', '13.500', '8.000', '20.000'],
      correctAnswer: '13.500',
      explanation:
          'Jumlah sekolah dasar pada awal masa Jepang turun menjadi 13.500',
    ),
    QuizQuestion2(
      id: 'E2',
      chapter: 'Pendidikan, Komunikasi Sosial, dan Budaya',
      question: 'Hakko Ichiu berarti...',
      options: [
        'Kemerdekaan',
        'Delapan benang di bawah satu atap',
        'Kerja bakti',
        'Lagu Jepang',
      ],
      correctAnswer: 'Delapan benang di bawah satu atap',
      explanation: 'Hakko Ichiu berarti delapan benang di bawah satu atap',
    ),
    QuizQuestion2(
      id: 'E3',
      chapter: 'Pendidikan, Komunikasi Sosial, dan Budaya',
      question: 'Bahasa apa yang dipaksakan Jepang di sekolah?',
      options: [
        'Bahasa Belanda',
        'Bahasa Indonesia',
        'Bahasa Jepang',
        'Bahasa Inggris',
      ],
      correctAnswer: 'Bahasa Jepang',
      explanation:
          'Jepang memaksakan penggunaan bahasa Jepang di sekolah-sekolah',
    ),
    QuizQuestion2(
      id: 'E4',
      chapter: 'Pendidikan, Komunikasi Sosial, dan Budaya',
      question: 'Sekolah kepandaian putri zaman Jepang bernama...',
      options: ['Shihan Gakko', 'Wakaba', 'Kokumin Gakko', 'Hokokai'],
      correctAnswer: 'Wakaba',
      explanation: 'Sekolah kepandaian putri pada zaman Jepang bernama Wakaba',
    ),
    QuizQuestion2(
      id: 'E5',
      chapter: 'Pendidikan, Komunikasi Sosial, dan Budaya',
      question: 'Apa sisi positif dari sistem pendidikan Jepang?',
      options: [
        'Gratis total',
        'Menghapus diskriminasi pendidikan',
        'Bebas biaya buku',
        'Guru dari Belanda',
      ],
      correctAnswer: 'Menghapus diskriminasi pendidikan',
      explanation:
          'Sisi positif sistem pendidikan Jepang adalah menghapus diskriminasi pendidikan',
    ),

    QuizQuestion2(
      id: 'F1',
      chapter: 'Perlawanan Rakyat Terhadap Jepang',
      question:
          'Siapa ulama muda yang memimpin perlawanan di Cot Plieng, Aceh?',
      options: [
        'KH Zaenal Mustafa',
        'Teungku Abdul Djalil',
        'Haji Agus Salim',
        'Mas Mansur',
      ],
      correctAnswer: 'Teungku Abdul Djalil',
      explanation:
          'Teungku Abdul Djalil adalah ulama muda yang memimpin perlawanan di Cot Plieng, Aceh',
    ),
    QuizQuestion2(
      id: 'F2',
      chapter: 'Perlawanan Rakyat Terhadap Jepang',
      question: 'Perlawanan di Singaparna dipimpin oleh...',
      options: [
        'KH Zaenal Mustafa',
        'Abdul Karim Amrullah',
        'Hoesein Djajadiningrat',
        'Supriyadi',
      ],
      correctAnswer: 'KH Zaenal Mustafa',
      explanation: 'Perlawanan di Singaparna dipimpin oleh KH Zaenal Mustafa',
    ),
    QuizQuestion2(
      id: 'F3',
      chapter: 'Perlawanan Rakyat Terhadap Jepang',
      question: 'Pemberontakan PETA Blitar dipimpin oleh...',
      options: ['Sudirman', 'Supriyadi', 'Sutomo', 'Soekarno'],
      correctAnswer: 'Supriyadi',
      explanation: 'Pemberontakan PETA Blitar dipimpin oleh Supriyadi',
    ),
    QuizQuestion2(
      id: 'F4',
      chapter: 'Perlawanan Rakyat Terhadap Jepang',
      question: 'Alasan umat Islam menolak seikeirei adalah...',
      options: [
        'Dianggap rukuk kepada manusia',
        'Membuang waktu',
        'Tidak sopan',
        'Tidak sesuai budaya',
      ],
      correctAnswer: 'Dianggap rukuk kepada manusia',
      explanation:
          'Umat Islam menolak seikeirei karena dianggap seperti rukuk kepada manusia',
    ),
    QuizQuestion2(
      id: 'F5',
      chapter: 'Perlawanan Rakyat Terhadap Jepang',
      question: 'Jumlah korban dalam perlawanan Singaparna sekitar...',
      options: ['50 orang', '198 orang', '500 orang', '100 orang'],
      correctAnswer: '198 orang',
      explanation:
          'Jumlah korban dalam perlawanan Singaparna sekitar 198 orang',
    ),

    QuizQuestion2(
      id: 'G1',
      chapter: 'Janji dan Persiapan Kemerdekaan',
      question: 'Janji Koiso diumumkan pada tanggal...',
      options: [
        '7 September 1944',
        '17 Agustus 1945',
        '1 Maret 1945',
        '22 Juni 1945',
      ],
      correctAnswer: '7 September 1944',
      explanation: 'Janji Koiso diumumkan pada tanggal 7 September 1944',
    ),
    QuizQuestion2(
      id: 'G2',
      chapter: 'Janji dan Persiapan Kemerdekaan',
      question: 'Dokuritsu Junbi Cosokai dibentuk pada tanggal...',
      options: [
        '1 Maret 1945',
        '7 September 1944',
        '28 Mei 1945',
        '1 Juni 1945',
      ],
      correctAnswer: '1 Maret 1945',
      explanation:
          'Dokuritsu Junbi Cosokai (BPUPKI) dibentuk pada tanggal 1 Maret 1945',
    ),
    QuizQuestion2(
      id: 'G3',
      chapter: 'Janji dan Persiapan Kemerdekaan',
      question: 'Ketua BPUPKI adalah...',
      options: ['Soekarno', 'Moh. Hatta', 'Radjiman Wediodiningrat', 'Supomo'],
      correctAnswer: 'Radjiman Wediodiningrat',
      explanation: 'Ketua BPUPKI adalah Radjiman Wediodiningrat',
    ),
    QuizQuestion2(
      id: 'G4',
      chapter: 'Janji dan Persiapan Kemerdekaan',
      question: 'Pidato \'Lahirnya Pancasila\' disampaikan oleh...',
      options: ['Soekarno', 'Moh. Yamin', 'Supomo', 'Hatta'],
      correctAnswer: 'Soekarno',
      explanation: 'Pidato "Lahirnya Pancasila" disampaikan oleh Soekarno',
    ),
    QuizQuestion2(
      id: 'G5',
      chapter: 'Janji dan Persiapan Kemerdekaan',
      question: 'Panitia Sembilan menghasilkan...',
      options: ['Piagam Jakarta', 'Proklamasi', 'Undang-Undang', 'Dekrit'],
      correctAnswer: 'Piagam Jakarta',
      explanation: 'Panitia Sembilan menghasilkan Piagam Jakarta',
    ),

    QuizQuestion2(
      id: 'H1',
      chapter: 'Menjelang Proklamasi',
      question: 'PPKI dibentuk pada tanggal...',
      options: [
        '1 Juni 1945',
        '7 Agustus 1945',
        '14 Agustus 1945',
        '17 Agustus 1945',
      ],
      correctAnswer: '7 Agustus 1945',
      explanation: 'PPKI dibentuk pada tanggal 7 Agustus 1945',
    ),
    QuizQuestion2(
      id: 'H2',
      chapter: 'Menjelang Proklamasi',
      question:
          'Perbedaan utama golongan tua dan muda menjelang proklamasi adalah...',
      options: [
        'Golongan tua ingin segera proklamasi, golongan muda menunda',
        'Golongan tua menunggu sidang PPKI, golongan muda ingin segera proklamasi tanpa Jepang',
        'Golongan tua mendukung Jepang, golongan muda mendukung Belanda',
        'Golongan tua menolak proklamasi, golongan muda menerima',
      ],
      correctAnswer:
          'Golongan tua menunggu sidang PPKI, golongan muda ingin segera proklamasi tanpa Jepang',
      explanation:
          'Golongan tua menunggu sidang PPKI, sementara golongan muda ingin segera memproklamasikan kemerdekaan tanpa campur tangan Jepang',
    ),
    QuizQuestion2(
      id: 'H3',
      chapter: 'Menjelang Proklamasi',
      question:
          'Peristiwa Rengasdengklok dilakukan oleh golongan muda dengan tujuan...',
      options: [
        'Menghindari pengaruh Jepang terhadap Soekarno-Hatta',
        'Melindungi Soekarno-Hatta dari Sekutu',
        'Menyembunyikan senjata Jepang',
        'Membentuk organisasi baru',
      ],
      correctAnswer: 'Menghindari pengaruh Jepang terhadap Soekarno-Hatta',
      explanation:
          'Peristiwa Rengasdengklok dilakukan untuk menghindari pengaruh Jepang terhadap Soekarno-Hatta',
    ),
    QuizQuestion2(
      id: 'H4',
      chapter: 'Menjelang Proklamasi',
      question:
          'Siapa tokoh yang mengusulkan agar hanya Soekarno-Hatta yang menandatangani naskah Proklamasi?',
      options: ['Chairul Saleh', 'Sutan Sjahrir', 'Sukarni', 'Sajuti Melik'],
      correctAnswer: 'Sukarni',
      explanation:
          'Sukarni adalah tokoh yang mengusulkan agar hanya Soekarno-Hatta yang menandatangani naskah Proklamasi',
    ),
    QuizQuestion2(
      id: 'H5',
      chapter: 'Menjelang Proklamasi',
      question: 'Tokoh yang mengetik naskah Proklamasi Kemerdekaan adalah...',
      options: [
        'Ahmad Subardjo',
        'Sajuti Melik',
        'Latief Hendraningrat',
        'Wikana',
      ],
      correctAnswer: 'Sajuti Melik',
      explanation:
          'Sajuti Melik adalah tokoh yang mengetik naskah Proklamasi Kemerdekaan',
    ),
  ];

  // Method untuk mengambil soal berdasarkan difficulty
  static List<QuizQuestion2> getQuestionsByDifficulty(String difficulty) {
    switch (difficulty) {
      case 'Mudah':
        return allQuestions
            .where(
              (q) =>
                  q.chapter == 'Administrasi Pemerintahan' ||
                  q.chapter == 'Organisasi dan Kehidupan Sosial',
            )
            .take(10)
            .toList();

      case 'Sulit':
        return allQuestions
            .where(
              (q) =>
                  q.chapter == 'Romusha dan Mobilisasi Rakyat' ||
                  q.chapter == 'Ekonomi Perang' ||
                  q.chapter == 'Pendidikan, Komunikasi Sosial, dan Budaya',
            )
            .take(15)
            .toList();

      case 'Sedang':
        return allQuestions.skip(5).take(15).toList();

      case 'Campuran':
        return allQuestions;

      default:
        return allQuestions.take(10).toList();
    }
  }

  // Method untuk mengambil soal berdasarkan chapter
  static List<QuizQuestion2> getQuestionsByChapter(String chapter) {
    return allQuestions.where((q) => q.chapter == chapter).toList();
  }

  // Method untuk mengambil soal berdasarkan multiple chapters
  static List<QuizQuestion2> getQuestionsByChapters(List<String> chapters) {
    return allQuestions.where((q) => chapters.contains(q.chapter)).toList();
  }

  // Method untuk mengambil soal berdasarkan source category
  static List<QuizQuestion2> getQuestionsBySource(String source, int count) {
    List<QuizQuestion2> questions = [];

    switch (source) {
      case 'basic':
        questions =
            allQuestions
                .where(
                  (q) =>
                      q.chapter == 'Administrasi Pemerintahan' ||
                      q.chapter == 'Organisasi dan Kehidupan Sosial',
                )
                .toList();
        break;

      case 'intermediate':
        questions =
            allQuestions
                .where(
                  (q) =>
                      q.chapter == 'Romusha dan Mobilisasi Rakyat' ||
                      q.chapter == 'Ekonomi Perang' ||
                      q.chapter == 'Pendidikan, Komunikasi Sosial, dan Budaya',
                )
                .toList();
        break;

      case 'advanced':
        questions =
            allQuestions
                .where(
                  (q) =>
                      q.chapter == 'Perlawanan Rakyat Terhadap Jepang' ||
                      q.chapter == 'Janji dan Persiapan Kemerdekaan' ||
                      q.chapter == 'Menjelang Proklamasi',
                )
                .toList();
        break;

      default:
        questions = allQuestions;
    }

    // Shuffle dan ambil sesuai count
    questions.shuffle();
    return questions.take(count).toList();
  }

  // Method untuk mendapatkan distribusi chapter
  static Map<String, int> getChapterDistribution() {
    Map<String, int> distribution = {};
    for (var question in allQuestions) {
      distribution[question.chapter] =
          (distribution[question.chapter] ?? 0) + 1;
    }
    return distribution;
  }

  // Method untuk mendapatkan statistik berdasarkan difficulty
  static Map<String, int> getDifficultyStats() {
    return {
      'Basic': getQuestionsBySource('basic', 999).length,
      'Intermediate': getQuestionsBySource('intermediate', 999).length,
      'Advanced': getQuestionsBySource('advanced', 999).length,
    };
  }
}

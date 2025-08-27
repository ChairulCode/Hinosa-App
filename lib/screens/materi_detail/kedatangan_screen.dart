import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hinosaapp/screens/materi_screen.dart';

class KedatanganJepangDetail extends BaseMateriDetail {
  const KedatanganJepangDetail({super.key});

  @override
  State<KedatanganJepangDetail> createState() => _KedatanganJepangDetailState();
}

class _KedatanganJepangDetailState
    extends BaseMateriDetailState<KedatanganJepangDetail> {
  @override
  String get title => 'Kedatangan Jepang di Indonesia';

  @override
  Color get color => Colors.blue;

  @override
  List<Map<String, dynamic>> get sections => [
    {
      'title': '1. Masuknya Jepang di Indonesia',
      'content': [
        'Pada 8 Desember 1941, Jepang melancarkan serangan besar-besaran ke Pearl Harbor, markas Angkatan Laut Amerika Serikat di Pasifik.',
        'Target berikutnya adalah Indonesia (Hindia Belanda) karena kaya sumber daya alam: minyak bumi, timah, dan aluminium.',
        'Awal Januari 1942, pasukan Jepang mendarat di Ambon, menguasai Maluku, lalu merebut Tarakan dan Balikpapan (12 Januari).',
        'Pada 5 Maret 1942: Batavia (Jakarta) direbut Jepang',
        '8 Maret 1942: Belanda menyerah tanpa syarat dalam Kapitulasi Kalijati, Subang',
      ],
    },
    {
      'title': '2. Sambutan Rakyat Indonesia',
      'content': [
        'Rakyat Indonesia menyambut Jepang dengan gembira sebagai "Saudara Tua"',
        'Antusiasme dipengaruhi oleh kebencian terhadap Belanda dan ramalan Jayabaya',
        'Jepang mengusung slogan Hakko Ichiu "Satu Keluarga di Bawah Langit"',
        'Membentuk Gerakan Tiga A dengan slogan: Nippon Cahaya Asia, Nippon Pelindung Asia, Nippon Pemimpin Asia',
      ],
    },
  ];
}

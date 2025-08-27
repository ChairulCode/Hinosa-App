import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hinosaapp/screens/materi_screen.dart';

class PengerahanPenindasanDetail extends BaseMateriDetail {
  const PengerahanPenindasanDetail({super.key});

  @override
  State<PengerahanPenindasanDetail> createState() =>
      _PengerahanPenindasanDetailState();
}

class _PengerahanPenindasanDetailState
    extends BaseMateriDetailState<PengerahanPenindasanDetail> {
  @override
  String get title => 'Pengerahan dan Penindasan versus Perlawanan';

  @override
  Color get color => Colors.orange;

  @override
  List<Map<String, dynamic>> get sections => [
    {
      'title': '1. Ekonomi Perang Jepang',
      'content': [
        'Jepang mengerahkan seluruh kekuatan Indonesia untuk kepentingan perang melawan Sekutu',
        'Perubahan sektor perkebunan: mengurangi tebu, tembakau, teh, kopi dan menggantinya dengan padi, jagung, jarak, dan kina',
        'Kebijakan wajib serah padi: 40% untuk petani, 30% untuk pemerintah, 30% untuk bibit',
        'Bank-bank Belanda digantikan bank Jepang, uang Belanda diganti invasion money',
      ],
    },
    {
      'title': '2. Pengendalian Pendidikan',
      'content': [
        'Sekolah dasar turun dari 21.500 menjadi 13.500',
        'Sekolah lanjutan turun drastis dari 850 menjadi 20 sekolah',
        'Bahasa Indonesia sebagai pengantar, bahasa Jepang wajib dipelajari',
        'Siswa wajib mengikuti kegiatan kinrohosyi (kerja bakti) dan latihan kemiliteran',
      ],
    },
    {
      'title': '3. Pengerahan Romusa',
      'content': [
        'Romusa: tenaga kerja paksa untuk membantu Perang Asia Timur Raya',
        'Dipekerjakan membangun kubu pertahanan, jalan raya, dan lapangan udara',
        'Sekitar 300.000 romusa dikirim keluar Jawa, bahkan ke luar negeri',
        'Banyak yang meninggal karena kondisi kerja yang menyiksa dan kurang gizi',
      ],
    },
    {
      'title': '4. Perlawanan Rakyat',
      'content': [
        'Perlawanan di Cot Plieng, Aceh (10 November 1942) - Dipimpin Abdul Jalil',
        'Perlawanan di Singaparna - Dipimpin Kiai Zainal Mustafa',
        'Perlawanan di Indramayu - Petani melawan kebijakan wajib serah padi',
        'Perlawanan PETA di Blitar (29 Februari 1945) - Dipimpin Supriyadi',
      ],
    },
  ];
}

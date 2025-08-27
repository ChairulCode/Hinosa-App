import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hinosaapp/screens/materi_screen.dart';

class DramaAkhirDetail extends BaseMateriDetail {
  const DramaAkhirDetail({super.key});

  @override
  State<DramaAkhirDetail> createState() => _DramaAkhirDetailState();
}

class _DramaAkhirDetailState extends BaseMateriDetailState<DramaAkhirDetail> {
  @override
  String get title => 'Drama Akhir Sang Tirani';

  @override
  Color get color => Colors.red;

  @override
  List<Map<String, dynamic>> get sections => [
    {
      'title': '1. Dampak di Bidang Politik',
      'content': [
        'Penghapusan bahasa Belanda, diganti bahasa Jepang',
        'Struktur pemerintahan dirombak: desa (Ku), kecamatan (So), kabupaten (Ken)',
        'Pembentukan organisasi propaganda seperti Gerakan Tiga A dan Putera',
        'September 1943: PM Tojo menjanjikan kemerdekaan Indonesia',
      ],
    },
    {
      'title': '2. Dampak Sosial-Budaya dan Ekonomi',
      'content': [
        'Pengerahan romusa secara paksa menyebabkan penderitaan rakyat',
        'Kekurangan pangan karena banyak petani menjadi romusa',
        'Gelandangan memenuhi kota, penyakit kudis merebak',
        'Inflasi parah, rakyat terpaksa mengenakan karung goni sebagai pakaian',
      ],
    },
    {
      'title': '3. Dampak di Bidang Pendidikan',
      'content': [
        'Pembatasan pendidikan: sekolah dasar dipersingkat 6 tahun',
        'Bahasa Jepang wajib, siswa harus mempelajari adat istiadat Jepang',
        'Perguruan tinggi sempat ditutup (1943), hanya beberapa yang dibuka kembali',
        'Pemuda didorong masuk organisasi militer seperti Heiho dan Seinendan',
      ],
    },
    {
      'title': '4. Janji Kemerdekaan',
      'content': [
        'Tahun 1944: posisi Jepang melemah, memberikan janji kemerdekaan',
        '1 Maret 1945: pembentukan BPUPKI dengan 60 tokoh Indonesia',
        '1 Juni 1945: Sukarno memperkenalkan Pancasila sebagai dasar negara',
        'Pembentukan Panitia Sembilan dan lahirnya Piagam Jakarta',
      ],
    },
  ];
}

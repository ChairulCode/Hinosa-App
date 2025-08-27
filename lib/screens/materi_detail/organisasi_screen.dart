import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hinosaapp/screens/materi_screen.dart';

class OrganisasiPergerakanDetail extends BaseMateriDetail {
  const OrganisasiPergerakanDetail({super.key});

  @override
  State<OrganisasiPergerakanDetail> createState() =>
      _OrganisasiPergerakanDetailState();
}

class _OrganisasiPergerakanDetailState
    extends BaseMateriDetailState<OrganisasiPergerakanDetail> {
  @override
  String get title => 'Organisasi Pergerakan pada Masa Pendudukan Jepang';

  @override
  Color get color => Colors.green;

  @override
  List<Map<String, dynamic>> get sections => [
    {
      'title': '1. Organisasi Sosial Kemasyarakatan',
      'content': [
        'Gerakan Tiga A (29 Maret 1942) - Dipimpin Mr. Syamsuddin',
        'Pusat Tenaga Rakyat/Putera (16 April 1943) - Dipimpin "Empat Serangkai": Sukarno, Hatta, Ki Hajar Dewantara, K.H. Mas Mansyur',
        'MIAI (4 September 1942) - Untuk memperkuat kedudukan umat Islam',
        'Masyumi (November 1943) - Pengganti MIAI, dipimpin Hasyim Asy\'ari',
        'Jawa Hokokai (1944) - Himpunan Kebaktian Jawa',
      ],
    },
    {
      'title': '2. Organisasi Semi Militer',
      'content': [
        'Seinendan (Korps Pemuda) - Untuk pemuda usia 14-22 tahun',
        'Keibodan (Korps Kewaspadaan) - Anggota pemuda 25-35 tahun',
        'Barisan Pelopor - Dipimpin Ir. Sukarno, anggota ±60.000 pemuda',
        'Hizbullah (15 Desember 1944) - Tentara Allah, dipimpin KH. Zainul Arifin',
      ],
    },
    {
      'title': '3. Organisasi Militer',
      'content': [
        'Heiho (Pasukan Pembantu) - Jumlah anggota ±42.000 orang',
        'PETA (3 Oktober 1943) - Pembela Tanah Air, jumlah anggota ±37.000 di Jawa',
        'Struktur kepangkatan: Daidanco, Cudanco, Shodanco, Budanco & Giyuhei',
        'Tokoh terkenal: Supriyadi, Sudirman',
      ],
    },
  ];
}

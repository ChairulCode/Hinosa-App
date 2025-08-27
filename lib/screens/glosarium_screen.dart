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
    'Teknologi',
    'Pemrograman',
    'Database',
    'Networking',
    'UI/UX',
  ];

  final List<Map<String, String>> glosariumData = [
    {
      'term': 'API',
      'definition':
          'Application Programming Interface - sekumpulan protokol, rutinitas, dan alat untuk membangun aplikasi software.',
      'category': 'Teknologi',
    },
    {
      'term': 'Flutter',
      'definition':
          'Framework UI toolkit dari Google untuk membangun aplikasi natively compiled untuk mobile, web, dan desktop dari satu codebase.',
      'category': 'Pemrograman',
    },
    {
      'term': 'Widget',
      'definition':
          'Komponen dasar pembangun UI dalam Flutter. Segala sesuatu dalam Flutter adalah widget.',
      'category': 'Pemrograman',
    },
    {
      'term': 'Database',
      'definition':
          'Kumpulan data yang terorganisir dan tersimpan secara sistematis untuk memudahkan pencarian dan pengelolaan.',
      'category': 'Database',
    },
    {
      'term': 'HTTP',
      'definition':
          'HyperText Transfer Protocol - protokol komunikasi yang digunakan untuk sistem informasi hypermedia terdistribusi.',
      'category': 'Networking',
    },
    {
      'term': 'UI',
      'definition':
          'User Interface - antarmuka pengguna yang memungkinkan interaksi antara manusia dan komputer.',
      'category': 'UI/UX',
    },
    {
      'term': 'UX',
      'definition':
          'User Experience - keseluruhan pengalaman pengguna ketika berinteraksi dengan produk atau layanan.',
      'category': 'UI/UX',
    },
    {
      'term': 'JSON',
      'definition':
          'JavaScript Object Notation - format pertukaran data ringan yang mudah dibaca dan ditulis.',
      'category': 'Teknologi',
    },
    {
      'term': 'SQL',
      'definition':
          'Structured Query Language - bahasa pemrograman untuk mengelola dan mengakses database relasional.',
      'category': 'Database',
    },
    {
      'term': 'Git',
      'definition':
          'Sistem kontrol versi terdistribusi untuk melacak perubahan dalam source code selama pengembangan software.',
      'category': 'Teknologi',
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
            "Glosarium",
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
                colors: [Colors.blue, Color(0xFF2196F3)],
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
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search Bar
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

                // Category Filter
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
      case 'Teknologi':
        return Colors.blue;
      case 'Pemrograman':
        return Colors.green;
      case 'Database':
        return Colors.orange;
      case 'Networking':
        return Colors.purple;
      case 'UI/UX':
        return Colors.pink;
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

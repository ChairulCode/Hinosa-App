import 'package:flutter/material.dart';
import 'package:hinosaapp/service/auth_service.dart';
import 'package:hinosaapp/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = AuthService();
  int _selectedIndex = 0;

  String? _fullName;
  bool _loading = true;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  Future<void> _initUser() async {
    if (!auth.isLoggedIn) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
      return;
    }

    final name = await auth.getFullName();
    debugPrint("✅ Fullname loaded in HomeScreen: $name");

    if (mounted) {
      setState(() {
        _fullName = name ?? "User";
        _loading = false;

        _pages.addAll([
          _buildHomeContent(),
          const Center(child: Text("📚 Kursus / Kelas Belajar")),
          const Center(child: Text("💬 Forum Diskusi")),
          const Center(child: Text("📊 Progress Belajar")),
          const Center(child: Text("👤 Profil")),
        ]);
      });
    }
  }

  Future<void> _logout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Konfirmasi Logout"),
          content: const Text("Apakah Anda yakin ingin logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Tidak"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Ya"),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      await auth.signOut();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hinosa App",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            color: Colors.white,
          ),
        ],
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
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red[700],
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Kursus"),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: "Diskusi"),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Progress",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // === HEADER PROFILE ===
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.redAccent.shade400, Colors.redAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent.shade200.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 45, color: Colors.redAccent),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    "Selamat Datang, ${_fullName ?? 'User'} 👋",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildMenuCard("Persiapan belajar", Icons.book, Colors.blue),
              _buildMenuCard("Materi", Icons.bookmark_add, Colors.green),
              _buildMenuCard("Kuis & Latihan", Icons.quiz, Colors.orange),
              _buildMenuCard("Flash Card", Icons.card_giftcard, Colors.purple),
              _buildMenuCard("Konseling", Icons.chat, Colors.teal),
              _buildMenuCard("Tips & Motivasi", Icons.lightbulb, Colors.amber),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(String title, IconData icon, Color color) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.15),
                radius: 30,
                child: Icon(icon, size: 30, color: color),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  // color: color.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

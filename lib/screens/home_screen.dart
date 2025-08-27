import 'package:flutter/material.dart';
import 'package:hinosaapp/service/auth_service.dart';
import 'package:hinosaapp/screens/login_screen.dart';
import 'package:hinosaapp/screens/profile_screen.dart';
import 'package:hinosaapp/screens/materi_screen.dart';
import 'package:hinosaapp/screens/soal_screen.dart';
import 'package:hinosaapp/screens/flashcard_screen.dart';
import 'package:hinosaapp/screens/glosarium_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = AuthService();

  String? _fullName;
  String? _email;
  bool _loading = true;

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
    final email = await auth.getEmail();
    debugPrint("✅ Fullname loaded in HomeScreen: $name");
    debugPrint("✅ Email loaded in HomeScreen: $email");

    if (mounted) {
      setState(() {
        _fullName = name ?? "User";
        _email = email ?? "user@example.com";
        _loading = false;
      });
    }
  }

  void _openProfileScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ProfileScreen(
              fullName: _fullName ?? "User",
              email: _email ?? "user@example.com",
              auth: auth,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFBB002C), Color(0xFFE53935)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
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
          title: Row(
            children: [
              GestureDetector(
                onTap: _openProfileScreen,
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Color(0xFFBB002C)),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selamat Datang, ${_fullName ?? 'User'} 👋",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    "Hinosa App",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [const SizedBox(width: 8)],
        ),
      ),
      body: _buildHomeContent(),
    );
  }

  Widget _buildHomeContent() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Menu Utama",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFFBB002C),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              height: 3,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [Color(0xFFBB002C), Color(0xFFE53935)],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Cards in Column (not grid)
            _buildMenuCard("Materi", Icons.menu_book, Colors.red, true),
            _buildMenuCard("Soal", Icons.edit, Colors.red, false),
            _buildMenuCard("Flash Card", Icons.menu, Colors.red, true),
            _buildMenuCard("Glosarium", Icons.book, Colors.red, true),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    String title,
    IconData icon,
    Color color,
    bool boldText,
  ) {
    return InkWell(
      onTap: () {
        if (title == "Materi") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MateriScreen()),
          );
        } else if (title == "Soal") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SoalScreen()),
          );
        } else if (title == "Flash Card") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FlashCardScreen()),
          );
        } else if (title == "Glosarium") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const GlosariumScreen()),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFFCEFEA), // cream background
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFBB002C), width: 1.5),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: boldText ? FontWeight.bold : FontWeight.w500,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

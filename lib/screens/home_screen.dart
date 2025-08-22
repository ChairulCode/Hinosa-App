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

  /// Fungsi logout
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
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
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
    if (!auth.isLoggedIn) {
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hinosa App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
        backgroundColor: Color(0xFFBB002C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selamat datang, ${auth.currentUser?.email ?? 'User'} 👋",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            const Text(
              "Mau belajar apa hari ini :",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                    context,
                    title: "Materi",
                    icon: Icons.menu_book,
                    color: Colors.blue,
                    onTap: () {
                      // TODO: arahkan ke halaman materi
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Menu Materi belum dibuat"),
                        ),
                      );
                    },
                  ),
                  _buildMenuCard(
                    context,
                    title: "Latihan Soal",
                    icon: Icons.quiz,
                    color: Colors.green,
                    onTap: () {
                      // TODO: arahkan ke halaman soal
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Menu Latihan Soal belum dibuat"),
                        ),
                      );
                    },
                  ),
                  _buildMenuCard(
                    context,
                    title: "Sejarah Jepang",
                    icon: Icons.history_edu,
                    color: Colors.red,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Menu Sejarah Jepang belum dibuat"),
                        ),
                      );
                    },
                  ),
                  _buildMenuCard(
                    context,
                    title: "Profil Pahlawan",
                    icon: Icons.flag,
                    color: Colors.orange,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Menu Profil Pahlawan belum dibuat"),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 5,
        color: color.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

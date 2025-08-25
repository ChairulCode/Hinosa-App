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
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.white),
              onPressed: () {
                // aksi notif
              },
            ),
            const SizedBox(width: 8),
          ],
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
          mainAxisSize: MainAxisSize.min,
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
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              children: [
                _buildMenuCard("Materi", Icons.bookmark_add, Colors.green),
                _buildMenuCard("Soal", Icons.quiz, Colors.orange),
                _buildMenuCard(
                  "Flash Card",
                  Icons.card_giftcard,
                  Colors.purple,
                ),
                _buildMenuCard("Glosarium", Icons.book, Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(String title, IconData icon, Color color) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.white, color.withOpacity(0.08)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.12),
                radius: 35,
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Profile Screen - Screen baru untuk menampilkan info profil dan logout
class ProfileScreen extends StatelessWidget {
  final String fullName;
  final String email;
  final AuthService auth;

  const ProfileScreen({
    super.key,
    required this.fullName,
    required this.email,
    required this.auth,
  });

  Future<void> _logout(BuildContext context) async {
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

    if (shouldLogout == true && context.mounted) {
      await auth.signOut();
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
    }
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
            "Profile",
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
                colors: [Color(0xFFBB002C), Color(0xFFE53935)],
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

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Avatar dengan ring keren
            const CircleAvatar(
              radius: 62,
              backgroundColor: Color(0xFFBB002C),
              child: CircleAvatar(
                radius: 58,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 80, color: Color(0xFFBB002C)),
              ),
            ),
            const SizedBox(height: 30),
            // Profile Info Card
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.person_outline,
                      color: Color(0xFFBB002C),
                    ),
                    title: const Text("Nama Lengkap"),
                    subtitle: Text(
                      fullName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.email_outlined,
                      color: Color(0xFFBB002C),
                    ),
                    title: const Text("Email"),
                    subtitle: Text(
                      email,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Logout Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () => _logout(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBB002C),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                  elevation: 6,
                  shadowColor: Colors.redAccent.withOpacity(0.4),
                ),
                icon: const Icon(Icons.logout, size: 22),
                label: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

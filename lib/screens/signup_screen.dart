import 'package:flutter/material.dart';
import 'package:hinosaapp/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final supabase = Supabase.instance.client;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Email dan password tidak boleh kosong!");
      return;
    }

    // Cek kalau user coba daftar sebagai admin
    if (email == "hinosaadmin@gmail.com") {
      _showMessage("Email ini hanya bisa digunakan untuk login sebagai Admin!");
      return;
    }

    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final user = response.user!;

        // Setelah berhasil signup → insert ke tabel profiles
        await supabase.from('profiles').insert({
          'id': user.id,
          'email': user.email,
          'role': 'user', // default role user
          'created_at': DateTime.now().toIso8601String(),
        });

        _showMessage("Akun berhasil dibuat, silakan login!");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    } on AuthException catch (e) {
      if (e.message.contains("already registered")) {
        _showMessage("Akun sudah terdaftar, silakan login.");
      } else {
        _showMessage("Terjadi error: ${e.message}");
      }
    } catch (e) {
      _showMessage("Error tidak diketahui: $e");
    }
  }

  Future<void> _signupWithGoogle() async {
    try {
      await supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: "io.supabase.flutter://login-callback/",
      );
    } on AuthException catch (e) {
      _showMessage("Gagal login dengan Google: ${e.message}");
    } catch (e) {
      _showMessage("Error tidak diketahui: $e");
    }

    print('Current session: ${Supabase.instance.client.auth.currentSession}');
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final creamHeight = screenHeight * 0.35;

    return Scaffold(
      body: Stack(
        children: [
          /// Background Curve
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, screenHeight),
            painter: BackgroundCurvePainter(),
          ),

          SafeArea(
            child: Column(
              children: [
                /// Logo
                SizedBox(
                  height: creamHeight,
                  child: Center(
                    child: Image.asset('assets/logo.png', height: 300),
                  ),
                ),

                /// Konten
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        const Text(
                          'Daftar',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 32.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 26),

                        /// Email
                        TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Masukkan email anda',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        /// Password
                        TextField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Masukkan kata sandi anda',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text(
                              'Lupa kata sandi? Reset',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFEEEEEE),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 26),

                        /// Signup button
                        SizedBox(
                          width: double.infinity,
                          height: 49,
                          child: ElevatedButton(
                            onPressed: _signup,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Daftar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFBB002C),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        /// Google Signup Button
                        SizedBox(
                          width: double.infinity,
                          height: 49,
                          child: ElevatedButton.icon(
                            onPressed: _signupWithGoogle,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            icon: Image.asset('assets/google.png', height: 24),
                            label: const Text(
                              'Daftar dengan Google',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 26),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sudah punya akun? Masuk",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom Painter
class BackgroundCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    /// Background merah
    paint.color = const Color(0xFFBB002C);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    /// Garis putih
    paint.color = Colors.white;
    Path whitePath =
        Path()
          ..moveTo(0, 0)
          ..lineTo(0, size.height * 0.35)
          ..quadraticBezierTo(
            size.width * 0.5,
            size.height * 0.55,
            size.width,
            size.height * 0.35,
          )
          ..lineTo(size.width, 0)
          ..close();
    canvas.drawPath(whitePath, paint);

    /// Cream
    paint.color = const Color(0xFFF5E6CC);
    Path creamPath =
        Path()
          ..moveTo(0, 0)
          ..lineTo(0, size.height * 0.34)
          ..quadraticBezierTo(
            size.width * 0.5,
            size.height * 0.54,
            size.width,
            size.height * 0.34,
          )
          ..lineTo(size.width, 0)
          ..close();

    canvas.drawPath(creamPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

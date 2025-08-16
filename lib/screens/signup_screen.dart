import 'package:flutter/material.dart';
import 'package:hinosaapp/screens/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();

  final supabase = Supabase.instance.client;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final fullName = _fullNameController.text.trim();

    if (email.isEmpty || password.isEmpty || fullName.isEmpty) {
      _showMessage("Nama lengkap, email, dan password tidak boleh kosong!");
      return;
    }

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

        await supabase.from('profiles').insert({
          'id': user.id,
          'email': user.email,
          'full_name': fullName,
          'avatar_url': null,
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
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

      supabase.auth.onAuthStateChange.listen((data) async {
        final session = data.session;
        final user = session?.user;

        if (user != null) {
          final profile =
              await supabase
                  .from('profiles')
                  .select()
                  .eq('id', user.id)
                  .maybeSingle();

          if (profile == null) {
            await supabase.from('profiles').insert({
              'id': user.id,
              'email': user.email,
              'full_name':
                  user.userMetadata?['full_name'], // ✅ Nama dari Google
              'avatar_url': user.userMetadata?['avatar_url'],
              'created_at': DateTime.now().toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
            });

            _showMessage("Akun baru berhasil dibuat, silakan login!");
          } else {
            _showMessage("Akun ini sudah terdaftar, silakan login!");
          }

          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          }
        }
      });
    } on AuthException catch (e) {
      _showMessage("Gagal login dengan Google: ${e.message}");
    } catch (e) {
      _showMessage("Error tidak diketahui: $e");
    }
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
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, screenHeight),
            painter: BackgroundCurvePainter(),
          ),

          SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: creamHeight,
                  child: Center(
                    child: Image.asset('assets/logo.png', height: 300),
                  ),
                ),

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

                        /// Nama Lengkap ✅
                        TextField(
                          controller: _fullNameController,
                          decoration: const InputDecoration(
                            labelText: 'Nama Lengkap',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

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

    paint.color = const Color(0xFFBB002C);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

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

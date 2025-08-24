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
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (_isLoading) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final fullName = _fullNameController.text.trim();

    print('🔍 DEBUG - Signup attempt:');
    print('📧 Email: $email');
    print('👤 Full Name: "$fullName"');
    print('🔒 Password length: ${password.length}');

    if (email.isEmpty || password.isEmpty || fullName.isEmpty) {
      _showMessage("Nama lengkap, email, dan password tidak boleh kosong!");
      return;
    }

    if (email == "hinosaadmin@gmail.com") {
      _showMessage("Email ini hanya bisa digunakan untuk login sebagai Admin!");
      return;
    }

    setState(() => _isLoading = true);

    try {
      // ✅ Step 1: Buat user di auth + kirim full_name ke metadata
      print('🔑 Step 1: Creating auth user...');
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName, // dikirim ke raw_user_meta_data
        },
      );

      final user = response.user;
      print('✅ User created with ID: ${user?.id}');
      print('📝 raw_user_meta_data: ${user?.userMetadata}');

      if (user != null) {
        // ⛔️ Gak usah insert manual ke profiles → trigger yang ngurus
        print('⏳ Waiting for trigger to insert into profiles...');

        // ✅ Sign out biar user harus confirm email dulu
        await supabase.auth.signOut();
        print('👋 User signed out - awaiting email confirmation');

        _showMessage(
          "✅ Akun berhasil dibuat! Silakan cek email untuk konfirmasi, lalu login.",
        );

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }
      } else {
        print('❌ User creation failed - no user returned');
        _showMessage("Gagal membuat akun - tidak ada user yang dikembalikan");
      }
    } on AuthException catch (e) {
      print('🚫 AuthException: ${e.message}');
      if (e.message.contains("already registered")) {
        _showMessage("Akun sudah terdaftar, silakan login.");
      } else if (e.message.contains("email address invalid")) {
        _showMessage("Format email tidak valid.");
      } else if (e.message.contains("password")) {
        _showMessage("Password terlalu lemah. Minimal 6 karakter.");
      } else {
        _showMessage("Auth Error: ${e.message}");
      }
    } catch (e) {
      print('❌ Unexpected error: $e');
      _showMessage("Error tidak diketahui: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signupWithGoogle() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      print('🔍 Starting Google signup...');

      await supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: "io.supabase.flutter://login-callback/",
      );

      _showMessage("Redirecting to Google...");
    } on AuthException catch (e) {
      print('🚫 Google AuthException: ${e.message}');
      _showMessage("Gagal login dengan Google: ${e.message}");
    } catch (e) {
      print('❌ Google signup error: $e');
      _showMessage("Error Google signup: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showMessage(String msg) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          duration: const Duration(seconds: 4),
          backgroundColor: msg.contains('✅') ? Colors.green : null,
        ),
      );
    }
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

                        // Nama Lengkap
                        TextField(
                          controller: _fullNameController,
                          enabled: !_isLoading,
                          decoration: const InputDecoration(
                            labelText: 'Nama Lengkap',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 16),

                        // Email
                        TextField(
                          controller: _emailController,
                          enabled: !_isLoading,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Masukkan email anda',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 16),

                        // Password
                        TextField(
                          controller: _passwordController,
                          enabled: !_isLoading,
                          decoration: const InputDecoration(
                            labelText: 'Masukkan kata sandi anda',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            helperText: 'Minimal 6 karakter',
                            helperStyle: TextStyle(color: Colors.white70),
                          ),
                          style: const TextStyle(color: Colors.white),
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

                        // Signup button
                        SizedBox(
                          width: double.infinity,
                          height: 49,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _signup,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _isLoading ? Colors.grey : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 3,
                            ),
                            child:
                                _isLoading
                                    ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Color(0xFFBB002C),
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : const Text(
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

                        // Google Signup Button
                        SizedBox(
                          width: double.infinity,
                          height: 49,
                          child: ElevatedButton.icon(
                            onPressed: _isLoading ? null : _signupWithGoogle,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _isLoading ? Colors.grey : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 3,
                            ),
                            icon:
                                _isLoading
                                    ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.black87,
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : Image.asset(
                                      'assets/google.png',
                                      height: 24,
                                    ),
                            label: Text(
                              _isLoading
                                  ? 'Memproses...'
                                  : 'Daftar dengan Google',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 26),

                        GestureDetector(
                          onTap:
                              _isLoading
                                  ? null
                                  : () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => const LoginScreen(),
                                      ),
                                    );
                                  },
                          child: Text(
                            "Sudah punya akun? Masuk",
                            style: TextStyle(
                              fontSize: 14,
                              color: _isLoading ? Colors.grey : Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Info text
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Setelah mendaftar, silakan cek email untuk konfirmasi akun.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                            textAlign: TextAlign.center,
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

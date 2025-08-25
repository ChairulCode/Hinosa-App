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
  final _confirmPasswordController = TextEditingController();
  final _fullNameController = TextEditingController();

  final supabase = Supabase.instance.client;
  bool _isLoading = false;

  // buat toggle show password
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  // Fungsi untuk mengecek apakah email sudah terdaftar
  Future<bool> _isEmailRegistered(String email) async {
    try {
      // Mencoba sign in dengan email dan password dummy
      // Jika email tidak terdaftar, akan throw error "Invalid login credentials"
      // Jika email terdaftar, akan throw error "Invalid login credentials" atau berhasil

      // Alternatif: gunakan query ke auth.users jika memiliki akses admin
      // Atau gunakan fungsi edge function khusus untuk check email

      // Method sederhana: coba reset password
      await supabase.auth.resetPasswordForEmail(email);

      // Jika tidak ada error, berarti email terdaftar
      return true;
    } on AuthException catch (e) {
      print('🔍 Email check error: ${e.message}');

      // Jika error adalah "User not found" atau similar, email belum terdaftar
      if (e.message.toLowerCase().contains('user not found') ||
          e.message.toLowerCase().contains('email not confirmed') ||
          e.message.toLowerCase().contains('invalid email')) {
        return false;
      }

      // Untuk error lainnya, anggap email sudah terdaftar (safer approach)
      return true;
    } catch (e) {
      print('🔍 Unexpected error during email check: $e');
      // Jika ada error tidak diketahui, anggap email belum terdaftar
      return false;
    }
  }

  Future<void> _signup() async {
    if (_isLoading) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final fullName = _fullNameController.text.trim();

    // ✅ Validasi awal
    if (email.isEmpty ||
        password.isEmpty ||
        fullName.isEmpty ||
        confirmPassword.isEmpty) {
      _showMessage("Nama lengkap, email, dan password tidak boleh kosong!");
      return;
    }

    if (password != confirmPassword) {
      _showMessage("⚠️ Tolong sesuaikan kata sandi anda.");
      return;
    }

    if (email == "hinosaadmin@gmail.com") {
      _showMessage("Email ini hanya bisa digunakan untuk login sebagai Admin!");
      return;
    }

    setState(() => _isLoading = true);

    try {
      // ✅ Step 0: Check if email is already registered
      print('🔍 Step 0: Checking if email is already registered...');

      bool emailExists = await _isEmailRegistered(email);

      if (emailExists) {
        _showMessage(
          "⚠️ Akun dengan email ini sudah terdaftar sebelumnya. Silakan gunakan email lain atau login.",
        );
        setState(() => _isLoading = false);
        return;
      }

      print('🔑 Step 1: Creating auth user...');
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );

      final user = response.user;
      if (user != null) {
        print('✅ User created with ID: ${user.id}');

        await supabase.auth.signOut();
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
        _showMessage("❌ Gagal membuat akun - tidak ada user yang dikembalikan");
      }
    } on AuthException catch (e) {
      print('🚫 AuthException: ${e.message}');
      if (e.message.toLowerCase().contains("already registered") ||
          e.message.toLowerCase().contains("email already") ||
          e.message.toLowerCase().contains("user already exists")) {
        _showMessage(
          "⚠️ Akun dengan email ini sudah terdaftar sebelumnya. Silakan gunakan email lain atau login.",
        );
      } else if (e.message.toLowerCase().contains("invalid")) {
        _showMessage("Format email tidak valid.");
      } else if (e.message.toLowerCase().contains("password")) {
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

  void _showMessage(String msg) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          duration: const Duration(seconds: 4),
          backgroundColor:
              msg.contains('✅')
                  ? Colors.green
                  : msg.contains('⚠️')
                  ? Colors.orange
                  : null,
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
                          decoration: InputDecoration(
                            labelText: 'Masukkan kata sandi anda',
                            labelStyle: const TextStyle(color: Colors.white),
                            border: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            helperText: 'Minimal 6 karakter',
                            helperStyle: const TextStyle(color: Colors.white70),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          obscureText: _obscurePassword,
                        ),
                        const SizedBox(height: 16),

                        // Confirm Password
                        TextField(
                          controller: _confirmPasswordController,
                          enabled: !_isLoading,
                          decoration: InputDecoration(
                            labelText: 'Konfirmasi kata sandi anda',
                            labelStyle: const TextStyle(color: Colors.white),
                            border: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          obscureText: _obscureConfirmPassword,
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
                            onPressed: _isLoading ? null : () {},
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

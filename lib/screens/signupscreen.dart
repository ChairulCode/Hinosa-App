import 'package:flutter/material.dart';
import 'package:hinosaapp/screens/login_screen.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final creamHeight =
        screenHeight * 0.35; // tinggi cream sama kaya di painter

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
                /// Logo di tengah area cream
                SizedBox(
                  height: creamHeight,
                  child: Center(
                    child: Image.asset(
                      'assets/logo.png',
                      height: 300, // atur sesuai kebutuhan
                    ),
                  ),
                ),

                /// Konten lain (di atas background merah)
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          'Daftar',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 32.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 26),

                        /// email
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              'Lupa kata sandi? Reset',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFEEEEEE),
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                        const SizedBox(height: 26),

                        /// Login button
                        SizedBox(
                          width: double.infinity,
                          height: 49,
                          child: ElevatedButton(
                            onPressed: () {},
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
                                color: const Color(0xFFBB002C),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 26),

                        /// Forgot Password
                        const SizedBox(height: 10),

                        /// Navigate to Sign Up
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
                            "Belum memiliki akun? Masuk",
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

/// Custom Painter untuk background curve
class BackgroundCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    /// Bagian bawah merah (full background)
    paint.color = const Color(0xFFBB002C); // merah
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    /// --- GARIS PUTIH (separator) ---
    paint.color = Colors.white;
    Path whitePath =
        Path()
          ..moveTo(0, 0)
          ..lineTo(0, size.height * 0.35)
          ..quadraticBezierTo(
            size.width * 0.5,
            size.height * 0.55, // lebih smooth
            size.width,
            size.height * 0.35,
          )
          ..lineTo(size.width, 0)
          ..close();
    canvas.drawPath(whitePath, paint);

    /// --- CREAM ---
    paint.color = const Color(0xFFF5E6CC);
    Path creamPath =
        Path()
          ..moveTo(0, 0)
          ..lineTo(
            0,
            size.height * 0.34,
          ) // agak dikit di atas biar kelihatan garis putih
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

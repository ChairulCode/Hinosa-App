import 'package:flutter/material.dart';
import 'package:hinosaapp/screens/home_screen.dart';
import 'package:hinosaapp/screens/started_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xgkuvfejuicpciayxjok.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhna3V2ZmVqdWljcGNpYXl4am9rIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUxMDAwMzUsImV4cCI6MjA3MDY3NjAzNX0.4vwmLFjv-SMiVgZ8XQc-oxm58tbm-8t3RnSBoErpEK0',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartedScreen(),
    );
  }
}

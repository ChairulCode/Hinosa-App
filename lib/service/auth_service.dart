import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> signOut() async {
    try {
      // Logout dari Supabase (termasuk Google OAuth session)
      await supabase.auth.signOut();
    } catch (e) {
      throw Exception("Logout gagal: $e");
    }
  }

  User? get currentUser => supabase.auth.currentUser;

  bool get isLoggedIn => currentUser != null;
}

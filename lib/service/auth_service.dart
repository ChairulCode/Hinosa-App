import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  /// Cek apakah user sudah login
  bool get isLoggedIn => supabase.auth.currentUser != null;

  /// Get current user
  User? get currentUser => supabase.auth.currentUser;

  /// Get full name dari database profiles
  Future<String?> getFullName() async {
    try {
      final user = currentUser;
      if (user == null) {
        print('❌ No user logged in');
        return null;
      }

      print('🔍 Getting full name for user: ${user.id}');

      final response =
          await supabase
              .from('profiles')
              .select('full_name')
              .eq('id', user.id)
              .maybeSingle();

      if (response != null && response['full_name'] != null) {
        final fullName = response['full_name'].toString().trim();
        print('✅ Full name found: "$fullName"');
        return fullName.isNotEmpty ? fullName : null;
      } else {
        print('❌ No full_name found in database');

        // Fallback: coba dari user metadata (Google login)
        if (user.userMetadata?['full_name'] != null) {
          final metadataName = user.userMetadata!['full_name'];
          print('🔄 Using metadata full_name: "$metadataName"');
          return metadataName;
        } else if (user.userMetadata?['name'] != null) {
          final metadataName = user.userMetadata!['name'];
          print('🔄 Using metadata name: "$metadataName"');
          return metadataName;
        }

        return null;
      }
    } catch (e) {
      print('❌ Error getting full name: $e');
      return null;
    }
  }

  /// Get email dari current user
  String? getEmail() {
    return currentUser?.email;
  }

  /// Sign out user
  /// Sign out user
  Future<bool> signOut() async {
    try {
      await supabase.auth.signOut();
      print('✅ User signed out successfully');
      return true;
    } catch (e) {
      print('❌ Error signing out: $e');
      return false; // ⬅️ return false kalau error
    }
  }

  /// Update full name di database
  Future<bool> updateFullName(String fullName) async {
    try {
      final user = currentUser;
      if (user == null) return false;

      await supabase
          .from('profiles')
          .update({'full_name': fullName})
          .eq('id', user.id);

      print('✅ Full name updated successfully: "$fullName"');
      return true;
    } catch (e) {
      print('❌ Error updating full name: $e');
      return false;
    }
  }

  /// Get user profile lengkap
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final user = currentUser;
      if (user == null) return null;

      final response =
          await supabase
              .from('profiles')
              .select('*')
              .eq('id', user.id)
              .maybeSingle();

      return response;
    } catch (e) {
      print('❌ Error getting user profile: $e');
      return null;
    }
  }
}

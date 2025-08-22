import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  // Check if user is logged in
  bool get isLoggedIn => supabase.auth.currentUser != null;

  // Get current user
  User? get currentUser => supabase.auth.currentUser;

  // Sign in method with profile creation
  Future<AuthResponse> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    print('🔐 Attempting to sign in user: $email');

    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user != null) {
      print('✅ User signed in successfully: ${user.id}');

      // Check and create profile if needed
      await _ensureProfileExists(user);
    }

    return response;
  }

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    print('🔐 Attempting Google sign in...');

    await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: "io.supabase.flutter://login-callback/",
    );
  }

  // Ensure profile exists for user
  Future<void> _ensureProfileExists(User user) async {
    try {
      print('👤 Checking if profile exists for user: ${user.id}');

      // Check if profile already exists
      final existingProfile =
          await supabase
              .from('profiles')
              .select('id, full_name')
              .eq('id', user.id)
              .maybeSingle();

      if (existingProfile == null) {
        print('❌ No profile found, creating new profile...');

        // Try to get saved full name from signup process
        String? fullName;
        String? savedEmail;

        try {
          final prefs = await SharedPreferences.getInstance();
          fullName = prefs.getString('pending_full_name_${user.id}');
          savedEmail = prefs.getString('pending_email_${user.id}');

          if (fullName != null) {
            print('📝 Found saved full name: $fullName');

            // Clean up the temporary data
            await prefs.remove('pending_full_name_${user.id}');
            await prefs.remove('pending_email_${user.id}');
          }
        } catch (e) {
          print('⚠️ Error retrieving saved data: $e');
        }

        // Fallback values
        fullName ??=
            user.userMetadata?['full_name'] ??
            user.userMetadata?['name'] ??
            'User';

        final email = user.email ?? savedEmail ?? 'no-email';

        final profileData = {
          'id': user.id,
          'email': email,
          'full_name': fullName,
          'avatar_url':
              user.userMetadata?['avatar_url'] ?? user.userMetadata?['picture'],
          'created_at': DateTime.now().toIso8601String(),
          'updated_at': DateTime.now().toIso8601String(),
        };

        print('📝 Creating profile with data: $profileData');

        // Create the profile
        await supabase.from('profiles').insert(profileData);

        print('✅ Profile created successfully');
      } else {
        print('✅ Profile already exists: ${existingProfile['full_name']}');

        // If profile exists but full_name is empty, try to update it
        if (existingProfile['full_name'] == null ||
            existingProfile['full_name'].toString().isEmpty) {
          await _updateEmptyFullName(user.id);
        }
      }
    } catch (e) {
      print('❌ Error ensuring profile exists: $e');
      // Don't throw error - let login continue even if profile creation fails
    }
  }

  // Update empty full name
  Future<void> _updateEmptyFullName(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedFullName = prefs.getString('pending_full_name_$userId');

      if (savedFullName != null) {
        print('🔄 Updating empty full_name with: $savedFullName');

        await supabase
            .from('profiles')
            .update({
              'full_name': savedFullName,
              'updated_at': DateTime.now().toIso8601String(),
            })
            .eq('id', userId);

        // Clean up
        await prefs.remove('pending_full_name_$userId');

        print('✅ Full name updated successfully');
      }
    } catch (e) {
      print('❌ Error updating full name: $e');
    }
  }

  // Get user full name
  Future<String?> getFullName() async {
    final user = currentUser;
    if (user == null) return null;

    try {
      print('🔍 Getting full name for user: ${user.id}');

      final profile =
          await supabase
              .from('profiles')
              .select('full_name')
              .eq('id', user.id)
              .maybeSingle();

      final fullName = profile?['full_name'] as String?;
      print('📝 Retrieved full name: $fullName');

      return fullName?.isNotEmpty == true ? fullName : null;
    } catch (e) {
      print('❌ Error getting full name: $e');
      return null;
    }
  }

  // Get user profile
  Future<Map<String, dynamic>?> getUserProfile() async {
    final user = currentUser;
    if (user == null) return null;

    try {
      final profile =
          await supabase
              .from('profiles')
              .select('*')
              .eq('id', user.id)
              .maybeSingle();

      return profile;
    } catch (e) {
      print('❌ Error getting user profile: $e');
      return null;
    }
  }

  // Update user profile
  Future<void> updateProfile({String? fullName, String? avatarUrl}) async {
    final user = currentUser;
    if (user == null) throw Exception('No authenticated user');

    final updateData = <String, dynamic>{
      'updated_at': DateTime.now().toIso8601String(),
    };

    if (fullName != null) updateData['full_name'] = fullName;
    if (avatarUrl != null) updateData['avatar_url'] = avatarUrl;

    await supabase.from('profiles').update(updateData).eq('id', user.id);
  }

  // Sign out
  Future<void> signOut() async {
    print('👋 Signing out user...');
    await supabase.auth.signOut();
    print('✅ User signed out successfully');
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    await supabase.auth.resetPasswordForEmail(email);
  }

  // Listen to auth state changes
  Stream<AuthState> get authStateChanges => supabase.auth.onAuthStateChange;
}

import 'package:blog/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get session;
  Future<UserModel> signIn({required String email, required String password});
  Future<UserModel> signUp(
      {required String name, required String email, required String password});
  Future<UserModel?> getCurrentUserData();
}

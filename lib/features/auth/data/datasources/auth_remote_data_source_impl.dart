import 'package:blog/core/error/exceptions.dart';
import 'package:blog/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient client;
  AuthRemoteDataSourceImpl({required this.client});

  @override
  Session? get session => client.auth.currentSession;

  @override
  Future<UserModel> signIn(
      {required String email, required String password}) async {
    try {
      final response = await client.auth
          .signInWithPassword(password: password, email: email);
      if (response.user == null) {
        throw ServerException("User is null");
      }
      return UserModel.fromJson(response.user!.toJson()).copyWith(
        email: session?.user.email,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await client.auth
          .signUp(password: password, email: email, data: {"name": name});
      if (response.user == null) {
        throw ServerException("User is null");
      }
      return UserModel.fromJson(response.user!.toJson()).copyWith(
        email: session?.user.email,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (session != null) {
        final userData =
            await client.from('profiles').select().eq('id', session!.user.id);
        return UserModel.fromJson(userData.first).copyWith(
          email: session?.user.email,
        );
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

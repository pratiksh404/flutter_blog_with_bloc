abstract interface class AuthRemoteDataSource {
  Future<String> signIn({required String email, required String password});
  Future<String> signUp(
      {required String name, required String email, required String password});
}

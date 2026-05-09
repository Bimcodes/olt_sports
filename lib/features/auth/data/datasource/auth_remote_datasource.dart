import '../models/user_model.dart';

abstract class AuthRemoteDatasource {

  // abstract method to login in  
  Future<UserModel> login({
    // This user model type which is returned is the api response from our backend.
    required String email,
    required String password
  });

  // abstract method to sign up
  Future<UserModel> signUp({
    // This user model type which is returned is the api response from our backend.
    required String email,
    required String username,
    required String password,
    required String confirmPassword,
  });

  // abstract method to logout
  Future<void> logout();

}

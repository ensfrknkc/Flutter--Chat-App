import 'package:kbu_app/model/user_model.dart';

abstract class  AuthBase {

  Future<UserModel> currentUser();
  Future<UserModel> signInAnonymusly();
  Future<bool> signOut();
  Future<UserModel> signInWithEmailandPassword(String email,String password);
  Future<UserModel> createUserWithEmailandPassword(String email,String password);
  Future<UserModel> signInWithGoogle();

} 
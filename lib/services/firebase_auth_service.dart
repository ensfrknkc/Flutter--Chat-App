import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kbu_app/model/user_model.dart';
import 'package:kbu_app/services/auth_base.dart';

class FirebaseAuthService implements AuthBase {
  @override
  Future<UserModel> currentUser() async {
    try {
      await Firebase.initializeApp();
      User user = await Future.value(FirebaseAuth.instance.currentUser);
      return _userFromFirebase(user);
    } catch (e) {
      print("HATA CURRENT USER" + e.toString());
      return null;
    }
  }

  UserModel _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return UserModel(userID: user.uid,email: user.email);
  }

  @override
  Future<bool> signOut() async {
    try {
      await Firebase.initializeApp();
      await Future.value(FirebaseAuth.instance..signOut());
      return true;
    } catch (e) {
      print("sign out hata" + e.toString());
      return false;
    }
  }

  @override
  Future<UserModel> signInAnonymusly() async {
      await Firebase.initializeApp();
      UserCredential result = await FirebaseAuth.instance.signInAnonymously();
      return _userFromFirebase(result.user);
  }

  @override
  Future<UserModel> createUserWithEmailandPassword(
      String email, String password) async {
      await Firebase.initializeApp();
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(result.user);
  }

  @override
  Future<UserModel> signInWithEmailandPassword(
      String email, String password) async {
      await Firebase.initializeApp();
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(result.user);
  }

  Future<UserModel> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      //google ile giriş yaptık
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        UserCredential result =  await FirebaseAuth.instance.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: _googleAuth.idToken,
                accessToken: _googleAuth.accessToken));

        return _userFromFirebase(result.user);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}

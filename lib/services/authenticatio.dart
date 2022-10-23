import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_firebaseapp/database/databaseManage.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Registration

  Future createUser(String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DatabaseManager().CreateUser(name, 'male', 100, user!.uid);
      return user;
    } catch (err) {
      print(err.toString());
    }
  }

  //Login

  Future signInUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (err) {
      print(err);
    }
  }

  //logout

  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}

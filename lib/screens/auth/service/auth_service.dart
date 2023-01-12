import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future signIn(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  static Future getUser() async {
    final user = await FirebaseAuth.instance.currentUser!;
    // user.email!
    return user;
  }

  static Future LogOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

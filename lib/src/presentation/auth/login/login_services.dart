import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voice_text_translation_app/src/presentation/utils/constants/focus_node.dart';
import 'package:voice_text_translation_app/src/presentation/utils/routes/routes_name.dart';

class LoginServices with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void login(BuildContext context, String userName, String email,
      String password) async {
    setLoading(true);

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email.toString().trim(),
        password: password,
      );

      if (!userCredential.user!.emailVerified) {
        Utils.toastMessage("Welcome to the App");
      }

      setLoading(false);
      Navigator.pushReplacementNamed(context, Routename.voiceTranslation);
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      if (e.code == 'user-not-found') {
        Utils.toastMessage("User not found. Please create an account.");
      } else if (e.code == 'wrong-password') {
        Utils.toastMessage("Invalid password.");
      } else {
        Utils.toastMessage("Login failed: ${e.toString()}");
      }
    } catch (e) {
      setLoading(false);
      Utils.toastMessage("Unexpected error: ${e.toString()}");
    }
  }

  void updateUserInfo(String newUsername, String newEmail) {}
}

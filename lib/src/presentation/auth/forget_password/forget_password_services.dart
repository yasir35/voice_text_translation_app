import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voice_text_translation_app/src/presentation/utils/constants/focus_node.dart';
import 'package:voice_text_translation_app/src/presentation/utils/routes/routes_name.dart';

class ForgetPasswordServices with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void forgotPassword(BuildContext context, String email) async {
    setLoading(true);
    try {
      auth.sendPasswordResetEmail(email: email).then((value) {
        setLoading(false);
        Utils.toastMessage('Please Check Your Email to Recover Your PASSWORD');
        Navigator.pushNamed(context, Routename.loginScreen);
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
      });
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }
}

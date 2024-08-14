import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voice_text_translation_app/src/presentation/utils/constants/focus_node.dart';
import 'package:voice_text_translation_app/src/presentation/utils/routes/routes_name.dart';

class RegisterServices with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void registerScreen(
    BuildContext context,
    String userName,
    String phone,
    String address,
    String email,
    String password,
  ) async {
    setLoading(true);

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      User? users = userCredential.user;

      await usersCollection.doc(users!.uid).set({
        'uid': users.uid,
        'email': email,
        'userName': userName,
        'phone': phone,
        'address': address,
        'OnlineStatus': 'NoOne',
        'profile': '',
      });

      Utils.toastMessage("User Created Successfully");
      
      setLoading(false);
      Navigator.pushNamed(context, Routename.voiceTranslation);
    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }

  void clearData() {}
}

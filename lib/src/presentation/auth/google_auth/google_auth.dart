import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:voice_text_translation_app/src/presentation/utils/routes/routes_name.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        final User? user = userCredential.user;

        if (user != null) {
          Navigator.pushNamed(context, Routename.voiceTranslation);
        }

        return user;
      } else {
        // Handle Google Sign-In cancelation
        return null;
      }
    } catch (e) {
      // Handle Google Sign-In failure
      print("Error signing in with Google: $e");
      return null;
    }
  }
}

Future<void> signInWithGoogle(BuildContext context) async {
  final GoogleAuthService _googleAuthService = GoogleAuthService();
  User? user = await _googleAuthService.signInWithGoogle(context);
  if (user != null) {
    Navigator.pushNamed(context, Routename.voiceTranslation);
  } else {
  }
}


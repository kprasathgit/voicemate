import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:voicemate/src/oauth/oauth.service.dart';

class OAuthController with ChangeNotifier {
  OAuthController(this.oAuthService, this.googleSignIn);
  final OAuthService oAuthService;
  final GoogleSignIn googleSignIn;
  String? idToken;
  Future<GoogleSignInAccount?> signInWithGoogle() async {
    return await oAuthService.signInWithGoogle();
  }

  Future weSignIn(String id) async {
    return await oAuthService.webSignIn(id);
  }

  Future googleLogin() async {
    if (kIsWeb) {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      googleAuthProvider.setCustomParameters({'prompt': 'select_account'});
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithPopup(googleAuthProvider);
    } else {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);
    }

    notifyListeners();
  }

  Future logOut() async {
    if (kIsWeb) {
      // For Web: Only sign out from FirebaseAuth as googleSignIn is not used
      await FirebaseAuth.instance.signOut();
    } else {
      // For Mobile: Sign out from GoogleSignIn and FirebaseAuth
      await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
    }
  }

  Future saveOauthUser(String idToken) async {
    return await oAuthService.saveOauthUser(idToken);
  }
}

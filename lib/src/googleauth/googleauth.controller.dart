import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:voicemate/src/googleauth/googleauth.service.dart';

class GoogleAuthController with ChangeNotifier {
  GoogleAuthController(this.googleAuthService);
  final GoogleAuthService googleAuthService;

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    return await googleAuthService.signInWithGoogle();
  }

 Future weSignIn() async{
return await googleAuthService.webSignIn();

 }
}

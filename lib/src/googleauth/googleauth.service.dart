import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:voicemate/src/common/url.dart';

class GoogleAuthService {
  var headers = {'Content-Type': 'application/json'};

  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signInSilently();

      GoogleSignInAuthentication auth;
      String? idToken;
      if (googleSignInAccount != null) {
        auth = await googleSignInAccount.authentication;
        idToken = googleSignInAccount.id;
      } else {
        if (kIsWeb) {
          googleSignIn.signIn();
          return null; // Return null to indicate button rendering
        } else {
          // Initiate regular sign-in for mobile platforms
          final GoogleSignInAccount? newSignInAccount =
              await googleSignIn.signIn();
          if (newSignInAccount != null) {
            auth = await newSignInAccount.authentication;
            idToken = newSignInAccount.id;
          } else {
            return null; // User canceled the sign-in process
          }
        }
      }

      auth.idToken;
      if (idToken != null) {
        final String sessionToken = await sendTokenToBackend(idToken);
        return googleSignInAccount;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String> sendTokenToBackend(String idToken) async {
    var response = await http.post(Uri.parse(Urls.googleAuthUrl),
        headers: headers, body: jsonEncode({"idToken": idToken}));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return responseBody['sessionToken'];
    }
    throw Exception("Failed to validate token with backend: ${response.body}");
  }
}

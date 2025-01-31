import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:voicemate/src/loginscreen/loginscreen.view.dart';
import 'package:voicemate/src/oauth/oauth.controller.dart';
import 'package:voicemate/src/profile/profile.view.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  static const routeName = '/homePageView';
  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late OAuthController oAuthController;
  @override
  void initState() {
    oAuthController = Provider.of<OAuthController>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            User? firebaseUser = snapshot.data; // Firebase User object
            if (firebaseUser != null) {
              // Fetch the ID token using Firebase User's method
              firebaseUser.getIdToken().then((token) {
                if (token != null) {
                  // Save the token if it's not null
                  oAuthController.saveOauthUser(token);
                } else {
                  print("Token is null");
                }
              }).catchError((error) {
                print("Error getting token: $error");
              });
            } else {
              print("User data is null");
            }

            return ProfileView(snapshot.data!);
          } else if (snapshot.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Something Went Wrong.!")));
          }
          return const LoginScreenView();
        },
      ),
    );
  }
}

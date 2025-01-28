import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:voicemate/src/loginscreen/loginscreen.view.dart';
import 'package:voicemate/src/profile/profile.view.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  static const routeName = '/homePageView';
  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
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

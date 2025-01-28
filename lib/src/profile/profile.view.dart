import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voicemate/src/googleauth/googleauth.controller.dart';
import 'package:voicemate/src/homepage/homepage.view.dart';

class ProfileView extends StatelessWidget {
  // final GoogleSignInAccount user;
  // final VoidCallback onLogout;

  // ProfileView({
  //   required this.user,
  //   required this.onLogout,
  //});

  final User user;
  const ProfileView(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
//    final user = FirebaseAuth.instance.currentUser!;
    return Consumer<GoogleAuthController>(
      builder: (context, googleAuthController, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('User Profile'),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await googleAuthController.logOut();
                  Navigator.of(context).popAndPushNamed(HomePageView.routeName);
                },
                tooltip: 'Logout',
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // User Profile Image or Initial
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      user.photoURL != null && user.photoURL!.isNotEmpty
                          ? NetworkImage(user.photoURL!)
                          : null,
                  child: user.photoURL == null || user.photoURL!.isEmpty
                      ? Text(
                          user.displayName != null &&
                                  user.displayName!.isNotEmpty
                              ? user.displayName![0].toUpperCase()
                              : '?',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      : null,
                  backgroundColor:
                      user.photoURL == null || user.photoURL!.isEmpty
                          ? Colors.blue
                          : Colors.transparent,
                ),
                SizedBox(height: 16),
                // Display Name
                Text(
                  user.displayName ?? 'N/A',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                // Email
                Text(
                  user.email!,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                SizedBox(height: 16),
                // Additional User Information (if available)
                if (user.uid != null) ...[
                  Text(
                    'UID: ${user.uid}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                ],
                // if (user.id != null) ...[
                //   Text(
                //     'User ID: ${user.id}',
                //     style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                //     textAlign: TextAlign.center,
                //   ),
                // ],
              ],
            ),
          ),
        );
      },
    );
  }
}

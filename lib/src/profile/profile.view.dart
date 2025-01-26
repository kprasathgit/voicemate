import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProfileWidget extends StatelessWidget {
  final GoogleSignInAccount user;
  final VoidCallback onLogout;

  UserProfileWidget({
    required this.user,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: onLogout,
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
                  user.photoUrl != null && user.photoUrl!.isNotEmpty
                      ? NetworkImage(user.photoUrl!)
                      : null,
              child: user.photoUrl == null || user.photoUrl!.isEmpty
                  ? Text(
                      user.displayName != null && user.displayName!.isNotEmpty
                          ? user.displayName![0].toUpperCase()
                          : '?',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  : null,
              backgroundColor: user.photoUrl == null || user.photoUrl!.isEmpty
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
              user.email,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            // Additional User Information (if available)
            if (user.serverAuthCode != null) ...[
              Text(
                'Server Auth Code: ${user.serverAuthCode}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
            ],
            if (user.id != null) ...[
              Text(
                'User ID: ${user.id}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

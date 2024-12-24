import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  static const routeName = "/loginScreenView";

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  late Size size;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.purple.shade900,
              Colors.blue.shade900,
              Colors.black
            ],
            center: Alignment(0, -0.5),
            radius: size.width * 0.2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //GLowing App Logo
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.tealAccent.withOpacity(0.5),
                        blurRadius: 50,
                        spreadRadius: 10,
                      ),
                    ],
                    gradient: const LinearGradient(
                      colors: [Colors.tealAccent, Colors.blueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Icon(
                  Icons.mic,
                  size: 80,
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 20),
            //App Title
            Text(
              'Voic Mate',
              style: GoogleFonts.roboto(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    const Shadow(
                        color: Colors.tealAccent,
                        blurRadius: 10,
                        offset: Offset(0, 2))
                  ]),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Video. Chat. Clone. Translate. Voice Call. Video Call.',
              style: GoogleFonts.roboto(
                  fontSize: 18, color: Colors.white70, letterSpacing: 1.2),
            ),
          ],
        ),
      ),
    );
  }
}

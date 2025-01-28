import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voicemate/src/loginscreen/loginscreen.view.dart';

class InitScreenView extends StatefulWidget {
  const InitScreenView({super.key});
  static const routeName = "initScreenView";
  @override
  State<InitScreenView> createState() => _InitScreenViewState();
}

class _InitScreenViewState extends State<InitScreenView> {
  @override
  void initState() {
    // Future.delayed(
    //   const Duration(seconds: 2),
    //   () {
    //     Navigator.of(context).popAndPushNamed(LoginScreenView.routeName);
    //   },
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
          colors: [Colors.blue.shade900, Colors.black],
          center: const Alignment(0, -0.5),
          radius: 2,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
//Animated Loading Icons
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitPulse(
                  color: Colors.tealAccent,
                  size: 40,
                ),
                SizedBox(width: 10),
                SpinKitPulse(color: Colors.blueAccent, size: 40.0),
                SizedBox(width: 10),
                SpinKitPulse(color: Colors.purpleAccent, size: 40.0),
              ],
            ),
            const SizedBox(height: 30),
            //Loading Message
            Text(
              'Initializing...',
              style: GoogleFonts.roboto(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  const Shadow(
                      color: Colors.tealAccent,
                      blurRadius: 5,
                      offset: Offset(0, 2))
                ],
              ),
            ),

            const SizedBox(height: 10),
            // Animated Tagline

            Text(
              'Connecting you to technology...',
              style: GoogleFonts.roboto(
                  fontSize: 16, color: Colors.white70, letterSpacing: 1.2),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

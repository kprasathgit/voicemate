import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:voicemate/src/googleauth/googleauth.controller.dart';
import 'package:voicemate/src/googleauth/googleauth.service.dart';
import 'package:voicemate/src/profile/profile.view.dart';

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  static const routeName = "/loginScreenView";

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView>
    with SingleTickerProviderStateMixin {
  late Size screenSize;
  late AnimationController controller;
  late Animation<double> backGroundAnimation;
  late Animation<double> logoRotationAnimation;

  late double logoSize;
  late double titleFontSize;
  late double taglineFontSize;
  late double paddingHorizontal;
  late bool isWeb;
  late bool isDarkMode;
  late Orientation orientation;
  TextEditingController userNameController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  late FocusNode userNameFocus;
  late FocusNode passwordFocus;
  late GoogleAuthController googleAuthController;
  final GoogleAuthService googleAuthService = GoogleAuthService();
  @override
  void initState() {
    userNameFocus = FocusNode();
    passwordFocus = FocusNode();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat();
    backGroundAnimation =
        Tween<double>(begin: 0, end: 6.28).animate(controller);
    // logoRotationAnimation =
    //     Tween<double>(begin: 0, end: 2 * pi).animate(controller);
    logoRotationAnimation =
        Tween<double>(begin: 0, end: 6.28).animate(controller);
    googleAuthController =
        Provider.of<GoogleAuthController>(context, listen: false);
    userNameFocus.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    // Dispose the AnimationController before calling super.dispose()
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    isWeb = kIsWeb; // Check if the platform is web
    orientation = MediaQuery.of(context).orientation;
    final width = screenSize.width;
    // final height = screenSize.height;
    final theme = Theme.of(context);
    isDarkMode = theme.brightness == Brightness.dark;
    final padding = orientation == Orientation.portrait
        ? EdgeInsets.symmetric(horizontal: width * 0.1)
        : isWeb
            ? EdgeInsets.only(left: width * 0.05)
            : EdgeInsets.symmetric(
                horizontal: width * 0.05); // Adjust for landscape
    final gradientRadius = isWeb ? 1.8 : 1.0;

    if (isWeb) {
      logoSize = screenSize.width * 0.05; // 0.5% of the screen width
      titleFontSize = screenSize.width * 0.03; // 0.1% of screen width
      taglineFontSize = screenSize.width * 0.01; // 4% of screen width
      paddingHorizontal = screenSize.width * 0.35; // 20% of screen width
      return _buildWebLayout();
    } else {
      if (orientation == Orientation.portrait) {
        logoSize = screenSize.width * 0.25; // 25% of the screen width
        titleFontSize = screenSize.width * 0.06; // 6% of screen width
        taglineFontSize = screenSize.width * 0.05; // 5% of screen width
        paddingHorizontal = screenSize.width * 0.1; // 10% of screen width
        return _buildPortraitLayout();
      } else {
        logoSize = screenSize.width * 0.2; // 20% of the screen width
        titleFontSize = screenSize.width * 0.055; // 5.5% of screen width
        taglineFontSize = screenSize.width * 0.045; // 4.5% of screen width
        paddingHorizontal = screenSize.width * 0.05; // 5% of screen width
        return _buildLandscapeLayout();
      }
    }
  }

  Widget _buildWebLayout() {
    return _buildLayout();
  }

  Widget _buildPortraitLayout() {
    return _buildLayout();
  }

  Widget _buildLandscapeLayout() {
    return _buildLayout();
  }

  Widget _buildLayout() {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            // Background Animation
            Positioned.fill(
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          Colors.purple.shade900,
                          Colors.blue.shade900,
                          // Colors.blueGrey.shade100
                          Colors.blueGrey.shade300
                        ],
                        center: Alignment.topCenter,
                        radius: 1.0,
                        //  transform: GradientRotation(backGroundAnimation.value),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Main content (Login UI)
            isWeb
                ?
                // Positioned(
                //     left: screenSize.width * 0.03,
                //     top: screenSize.height * 0,
                //     bottom: screenSize.height * 0.15,
                //     width: screenSize.width * 0.4,
                //     child: mainUi(),
                //   )
                Align(
                    alignment: Alignment(0, 0),
                    child: FractionallySizedBox(
                        widthFactor: 0.3,
                        child: Card(
                            borderOnForeground: false,
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    24), // Smooth rounded corners
                                side: const BorderSide(
                                    color: Colors.transparent)),
                            color: Colors.white24,
                            child: mainUi())),
                  )
                : Align(
                    alignment: Alignment.center,
                    child: mainUi(),
                  )
          ],
        ),
      ),
    );
  }

  Widget mainUi() {
    return SafeArea(
        child:
            // ListView(
            //   padding: EdgeInsets.zero,
            //   children: [
            //     SizedBox(
            //       height: screenSize.height * 0.02, // 2% of the screen size
            //     ),
            //     _buildLogoSection(),
            //     _buildAuthButtonsSection(),
            //     _buildDivider(),
            //     _buildLoginFields(),
            //     _buildFooterLinks(),
            //   ],
            // ),
            SingleChildScrollView(
      padding: const EdgeInsets.all(0),
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            height: screenSize.height * 0.02, // 2% of the screen size
          ),
          _buildLogoSection(),
          _buildAuthButtonsSection(),
          _buildDivider(),
          _buildLoginFields(),
          _buildFooterLinks(),
        ],
      ),
    ));
  }

  Widget _buildLogoSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
// Spinning Logo with Glowing Effect
        AnimatedBuilder(
          animation: logoRotationAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: logoRotationAnimation.value,
              child: Container(
                height: logoSize,
                width: logoSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Colors.tealAccent, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.tealAccent.withOpacity(0.6),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child:
                    Icon(Icons.mic, size: logoSize * 0.7, color: Colors.white),
              ),
            );
          },
        ),
        // App Title
        Text(
          'Voice Mate',
          style: GoogleFonts.roboto(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              const Shadow(
                color: Colors.tealAccent,
                blurRadius: 3,
              ),
            ],
          ),
        ),
        // App Tagline
        Text(
          'The Future of Communication',
          style: GoogleFonts.roboto(
            fontSize: taglineFontSize,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  Widget _buildAuthButtonsSection() {
    return Column(
      children: [
        // Example of Auth Button (You can use your actual login button widgets here)
        _buildAuthButton('Sign in with Google', Colors.white, Colors.red,
            MdiIcons.google, true, () async {
          try {
            final GoogleSignInAccount? user = await _googleSignIn.signIn();
            if (user != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfileWidget(
                    user: user,
                    onLogout: () async {
                      await _googleSignIn.signOut();
                      
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            }
          } catch (error) {
            print('Sign in failed: $error');
          }
        }, Colors.black),
        _buildAuthButton('Sign in with Apple', Colors.white, Colors.black,
            Icons.apple, false, () {}, Colors.black),
      ],
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: FractionallySizedBox(
        widthFactor: 0.95,
        child: Row(
          children: [
            Expanded(
                child: Divider(
              color: Colors.white70,
            )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                'OR',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            Expanded(child: Divider(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginFields() {
    return Column(
      children: [
        _buildTextField(
            'Email Address', Icons.email, userNameController, userNameFocus),
        _buildTextField(
            'Password', Icons.lock, passwordController, passwordFocus,
            isObscureText: true),
      ],
    );
  }

  Widget _buildFooterLinks() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Forgot Password?',
              style: GoogleFonts.roboto(
                color: Colors.tealAccent,
              ),
            ),
          ),
        ),
        SizedBox(height: screenSize.height * 0.01), // 2% of screen height
        FractionallySizedBox(
          widthFactor: 0.3,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              // padding: EdgeInsets.symmetric(
              //   horizontal: screenSize.width * 0.3,//            ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                //fontSize: screenSize.width * 0.01
              ), // 5% of screen width
            ),
          ),
        ),
        SizedBox(height: screenSize.height * 0.02), // 2% of screen height

        Text(
          'Don’t have an account?',
          style: GoogleFonts.roboto(
            color: Colors.white70,
            //fontSize: screenSize.width * 0.01
          ),
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              'Create an Account',
              style: GoogleFonts.roboto(
                color: Colors.tealAccent,
                //  backgroundColor: Colors.teal
                //fontSize: screenSize.width * 0.01,
              ),
            )),
      ],
    );
  }

  // Widget _buildAuthButton(String text, Color bgColor, Color iconColor,
  //     IconData icon, bool isGoogle, VoidCallback onPressed, Color fontColor) {
  //   return ElevatedButton.icon(
  //     onPressed: onPressed,
  //     icon: Icon(icon, color: iconColor),
  //     label: Text(
  //       text,
  //       style: GoogleFonts.roboto(
  //           color: fontColor, fontSize: screenSize.width * 0.035),
  //     ),
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: bgColor,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(30),
  //       ),
  //       padding: EdgeInsets.symmetric(vertical: 15),
  //     ),
  //   );
  // }

  Widget _buildAuthButton(String text, Color bgColor, Color iconColor,
      IconData icon, bool isGoogle, VoidCallback onPressed, Color fontColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: FractionallySizedBox(
        widthFactor: 0.6,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, color: iconColor),
          label: Text(
            text,
            style: GoogleFonts.roboto(
              color: fontColor,
              // fontSize:
              //     isWeb ? screenSize.width * 0.01 : screenSize.width * 0.035
            ),
          ),
          style: isWeb
              ? ElevatedButton.styleFrom(
                  backgroundColor: bgColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //padding: EdgeInsets.symmetric(vertical: 30),
                  minimumSize:
                      Size(screenSize.width * 0.25, screenSize.height * 0.065),
                )
              : ElevatedButton.styleFrom(
                  backgroundColor: bgColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //padding: EdgeInsets.symmetric(vertical: 30),
                  minimumSize:
                      Size(screenSize.width, screenSize.height * 0.055),
                ),
        ),
      ),
    );
  }

  // Widget _buildTextField(String hintText, IconData icon,
  //     {bool isObscureText = false}) {
  //   return TextFormField(
  //     obscureText: true,
  //     decoration: InputDecoration(
  //       //   contentPadding: EdgeInsets.symmetric(vertical: 18),
  //       hintText: hintText,
  //       filled: true,
  //       fillColor: Colors.white,
  //       border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(30),
  //           borderSide: BorderSide.none),
  //       prefixIcon: Icon(icon, color: Colors.teal),
  //     ),
  //   );
  // }

  Widget _buildTextField(String hintText, IconData icon,
      TextEditingController textEditingController, FocusNode focusNode,
      {bool isObscureText = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenSize.height * 0.01,
      ),
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          obscureText: isObscureText,
          decoration: InputDecoration(
            //  contentPadding: EdgeInsets.symmetric(vertical: 20),
            hintText: hintText,
            //   hintStyle: GoogleFonts.roboto(fontSize: screenSize.width * 0.02),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none),
            prefixIcon: Icon(icon, color: Colors.teal),
          ),
        ),
      ),
    );
  }
}

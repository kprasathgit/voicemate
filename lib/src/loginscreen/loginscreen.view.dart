import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:voicemate/src/common/constantvalues.dart';

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

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10))
          ..repeat();
    // backGroundAnimation =
    //     Tween<double>(begin: 0, end: 6.28).animate(controller);
    logoRotationAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(controller);
    logoRotationAnimation =
        Tween<double>(begin: 0, end: 6.28).animate(controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    const isWeb = kIsWeb; // Check if the platform is web
    final orientation = MediaQuery.of(context).orientation;
    final width = screenSize.width;
    final height = screenSize.height;
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final padding = orientation == Orientation.portrait
        ? EdgeInsets.symmetric(horizontal: width * 0.1)
        : EdgeInsets.symmetric(
            horizontal: width * 0.05); // Adjust for landscape
    final gradientRadius = isWeb ? 1.8 : 1.0;

    if (isWeb) {
      logoSize = screenSize.width * 0.25; // 25% of the screen width
      titleFontSize = screenSize.width * 0.05; // 5% of screen width
      taglineFontSize = screenSize.width * 0.04; // 4% of screen width
      paddingHorizontal = screenSize.width * 0.2; // 20% of screen width
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

    // return Scaffold(
    //     backgroundColor: isDarkMode ? Colors.grey : Colors.white60,
    //     body: GestureDetector(
    //       onTap: () {
    //         FocusScope.of(context).unfocus();
    //       },
    //       child: Stack(
    //         children: [
    //           // Positioned.fill(
    //           //   child: AnimatedBuilder(
    //           //     animation: controller,
    //           //     builder: (context, child) {
    //           //       // return Transform(
    //           //       //   transform: Matrix4.rotationY(backGroundAnimation.value),
    //           //       //   //   angle: backGroundAnimation.value,
    //           //       //   child: Container(
    //           //       //     decoration: BoxDecoration(
    //           //       //       gradient: RadialGradient(
    //           //       //         colors: [
    //           //       //           //Colors.tealAccent,
    //           //       //           // Colors.blueAccent,
    //           //       //           Colors.purple.shade900,
    //           //       //           Colors.blue.shade900,
    //           //       //           Colors.black
    //           //       //         ],
    //           //       //         center: Alignment.center,
    //           //       //         radius: gradientRadius,
    //           //       //         transform: GradientRotation(backGroundAnimation.value),
    //           //       //       ),
    //           //       //     ),
    //           //       //   ),
    //           //       // );
    //           //       return Container(
    //           //         decoration: BoxDecoration(
    //           //           gradient: RadialGradient(
    //           //             colors: [
    //           //               //Colors.tealAccent,
    //           //               // Colors.blueAccent,
    //           //               Colors.purple.shade900,
    //           //               Colors.blue.shade900,
    //           //               Colors.white
    //           //             ],
    //           //             center: Alignment.center,
    //           //             radius: gradientRadius,
    //           //             //   transform: GradientRotation(backGroundAnimation.value),
    //           //           ),
    //           //         ),
    //           //       );
    //           //     },
    //           //   ),
    //           // ),
    //           // Positioned.fill(
    //           //   child: AnimatedBuilder(
    //           //     animation: controller,
    //           //     builder: (context, child) {
    //           //       final radians = controller.value * 2 * pi;
    //           //       return Container(
    //           //         decoration: BoxDecoration(
    //           //           gradient: RadialGradient(
    //           //             colors: [
    //           //               Colors.teal.withOpacity(0.8),
    //           //               Colors.blue.withOpacity(0.7),
    //           //               Colors.purple.withOpacity(0.6),
    //           //               Colors.white70,
    //           //             ],
    //           //             stops: const [0.1, 0.4, 0.7, 1.0],
    //           //             center: Alignment(
    //           //               0.5 * (1 + sin(radians)),
    //           //               0.5 * (1 + cos(radians)),
    //           //             ),
    //           //             radius: gradientRadius,
    //           //           ),
    //           //         ),
    //           //       );
    //           //     },
    //           //   ),
    //           // ),
    //           //Main content [Login UI]
    //           Padding(
    //             padding: padding,
    //             child: SafeArea(
    //               child: ListView(padding: const EdgeInsets.all(0), children: [
    //                 Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     //Spinnig Logo with Glowing effect
    //                     SizedBox(
    //                       height: height * 0.05,
    //                     ),
    //                     AnimatedBuilder(
    //                       animation: logoRotationAnimation,
    //                       builder: (context, child) {
    //                         return Transform.rotate(
    //                           angle: logoRotationAnimation.value,
    //                           child: Container(
    //                             height: width * 0.2, // 30% of screen width
    //                             width: width * 0.2, // 30% of screen width
    //                             decoration: BoxDecoration(
    //                               shape: BoxShape.circle,
    //                               gradient: LinearGradient(
    //                                 colors: [
    //                                   Colors.tealAccent,
    //                                   Colors.blueAccent
    //                                 ],
    //                                 begin: Alignment.topLeft,
    //                                 end: Alignment.bottomRight,
    //                               ),
    //                               boxShadow: [
    //                                 BoxShadow(
    //                                   color: Colors.tealAccent.withOpacity(0.6),
    //                                   blurRadius: 30,
    //                                   spreadRadius: 10,
    //                                 ),
    //                               ],
    //                             ),
    //                             child: Icon(Icons.mic,
    //                                 size: width * 0.14,
    //                                 color:
    //                                     Colors.white), // 20% of screen width,
    //                           ),
    //                         );
    //                       },
    //                     ),
    //                     //  SizedBox(height: height * 0.05), // 5% of screen height
    //                     // App Title
    //                     Text(
    //                       'Voice Mate',
    //                       style: GoogleFonts.roboto(
    //                         fontSize: height * 0.03,
    //                         fontWeight: FontWeight.bold,
    //                         color: Colors.white,
    //                         shadows: [
    //                           Shadow(
    //                             color: Colors.tealAccent,
    //                             blurRadius: 3,
    //                             //offset: Offset(0, 2),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                     // App Tagline
    //                     Text(
    //                       'The Future of Communication',
    //                       style: GoogleFonts.roboto(
    //                         fontSize: width * 0.05, // 5% of screen width
    //                         color: Colors.white70,
    //                       ),
    //                     ),
    //                     SizedBox(height: height * 0.05), // 5% of screen height
    //                     // OAuth2 Login Buttons
    //                     Column(
    //                       crossAxisAlignment: CrossAxisAlignment.stretch,
    //                       children: [
    //                         _buildAuthButton(
    //                           ConstantValues.googleOauthLabel,
    //                           isDarkMode ? Colors.black : Colors.white,
    //                           isDarkMode ? Colors.red : Colors.purple,
    //                           MdiIcons.google,
    //                           true,
    //                           () {
    //                             // Handle Google Login
    //                           },
    //                           isDarkMode ? Colors.white : Colors.black,
    //                         ),
    //                         SizedBox(
    //                             height: height * 0.02), // 2% of screen height
    //                         _buildAuthButton(
    //                           ConstantValues.appleOauthLabel,
    //                           isDarkMode ? Colors.black : Colors.white,
    //                           isDarkMode ? Colors.white : Colors.black,
    //                           Icons.apple,
    //                           false,
    //                           () {
    //                             // Handle Apple Login
    //                           },
    //                           isDarkMode ? Colors.white : Colors.black,
    //                         ),
    //                         // SizedBox(height: height * 0.02), // 2% of screen height
    //                         // _buildAuthButton('Login with GitHub', Colors.white,
    //                         //     Colors.black, Icons.code, () {
    //                         //   // Handle GitHub Login
    //                         // }),
    //                       ],
    //                     ),
    //                     SizedBox(height: height * 0.05), // 5% of screen height
    //                     // Divider
    //                     Row(
    //                       children: [
    //                         Expanded(
    //                           child: Divider(
    //                             color: Colors.grey.shade300,
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding:
    //                               const EdgeInsets.symmetric(horizontal: 8.0),
    //                           child: Text(
    //                             'OR',
    //                             style: TextStyle(color: Colors.grey.shade200),
    //                           ),
    //                         ),
    //                         Expanded(
    //                             child: Divider(color: Colors.grey.shade300)),
    //                       ],
    //                     ),
    //                     SizedBox(height: height * 0.02), // 2% of screen height
    //                     // Login Fields
    //                     _buildTextField('Email Address', Icons.email),
    //                     SizedBox(height: height * 0.02), // 2% of screen height
    //                     _buildTextField('Password', Icons.lock,
    //                         isObscureText: true),
    //                     SizedBox(height: height * 0.02), // 2% of screen height
    //                     // Forgot Password Link
    //                     Align(
    //                       alignment: Alignment.centerLeft,
    //                       child: TextButton(
    //                         onPressed: () {},
    //                         child: Text(
    //                           'Forgot Password?',
    //                           style: TextStyle(color: Colors.teal.shade700),
    //                         ),
    //                       ),
    //                     ),
    //                     SizedBox(height: height * 0.02), // 2% of screen height
    //                     // Login Button
    //                     ElevatedButton(
    //                       onPressed: () {},
    //                       style: ElevatedButton.styleFrom(
    //                         backgroundColor: Colors.teal,
    //                         padding: EdgeInsets.symmetric(
    //                           horizontal: width * 0.1,
    //                         ), // 2% of screen height
    //                         shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(30),
    //                         ),
    //                       ),
    //                       child: Text(
    //                         'Login',
    //                         style: TextStyle(
    //                             color: Colors.white,
    //                             fontSize: width * 0.05), // 5% of screen width
    //                       ),
    //                     ),
    //                     SizedBox(height: height * 0.02), // 2% of screen height
    //                     // Footer Links
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         Text('Don’t have an account?',
    //                             style: TextStyle(color: Colors.grey.shade700)),
    //                         TextButton(
    //                           onPressed: () {
    //                             // Navigate to Signup Screen
    //                           },
    //                           child: Text('Sign Up',
    //                               style:
    //                                   TextStyle(color: Colors.teal.shade700)),
    //                         ),
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //               ]),
    //             ),
    //           ),
    //         ],
    //       ),
    //     )
    //     //3D Like Immersive Background Animation
    //     );
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
                          Colors.white
                        ],
                        center: Alignment.center,
                        radius: 1.0,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Main content (Login UI)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: SafeArea(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildLogoSection(),
                    _buildAuthButtonsSection(),
                    _buildDivider(),
                    _buildLoginFields(),
                    _buildFooterLinks(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                  gradient: LinearGradient(
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
              Shadow(
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

  Widget _buildAuthButtonsSection() {
    return Column(
      children: [
        // Example of Auth Button (You can use your actual login button widgets here)
        _buildAuthButton('Sign in with Google', Colors.white, Colors.red,
            MdiIcons.google, true, () {}, Colors.black),
        _buildAuthButton('Sign in with Apple', Colors.white, Colors.black,
            Icons.apple, false, () {}, Colors.black),
      ],
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Divider(
        color: Colors.white70,
      ),
    );
  }

  Widget _buildLoginFields() {
    return Column(
      children: [
        _buildTextField('Email Address', Icons.email),
        _buildTextField('Password', Icons.lock, isObscureText: true),
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
              style: TextStyle(color: Colors.teal.shade700),
            ),
          ),
        ),
        SizedBox(height: screenSize.height * 0.02), // 2% of screen height
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            // padding: EdgeInsets.symmetric(
            //   horizontal: screenSize.width * 0.1,
            // ), // 2% of screen height
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            'Login',
            style: TextStyle(
                color: Colors.white,
                fontSize: screenSize.width * 0.05), // 5% of screen width
          ),
        ),
        SizedBox(height: screenSize.height * 0.02), // 2% of screen height

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don’t have an account?',
              style: GoogleFonts.roboto(
                  color: Colors.grey.shade700,
                  fontSize: screenSize.width * 0.01),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Create an Account',
                  style: GoogleFonts.roboto(
                      color: Colors.teal.shade700,
                      fontSize: screenSize.width * 0.01),
                )),
          ],
        ),
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
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: iconColor),
        label: Text(
          text,
          style: GoogleFonts.roboto(
              color: fontColor, fontSize: screenSize.width * 0.035),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(vertical: 15),
          minimumSize: Size(screenSize.width * 0.7, 50),
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
      {bool isObscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          //   contentPadding: EdgeInsets.symmetric(vertical: 18),
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
          prefixIcon: Icon(icon, color: Colors.teal),
        ),
      ),
    );
  }
}

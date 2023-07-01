import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vbuddyproject/Constants/color_constant.dart';
import 'package:vbuddyproject/SplashScreen/splash_screen.dart';
import 'package:vbuddyproject/authMainScreen/auth_screen.dart';
import 'package:vbuddyproject/nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color myAppBarColor = Color(0x76000000);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Swapify',
      theme: ThemeData(
        primarySwatch: mainUiColour,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      // home: SplashScreen(),
      home: Builder(
        builder: (BuildContext context) {
          return FutureBuilder(
            future: Future.delayed(Duration(seconds: 3)), // Adjust the duration to match your splash screen duration
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              } else {
                return StreamBuilder(
                  key: UniqueKey(), // Add a unique key here
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      return NavBar();
                    } else {
                      return AuthScreen();
                    }
                  },
                );
              }
            },
          );
        },
      ),

    );
  }
}


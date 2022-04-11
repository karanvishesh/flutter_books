import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_books/view/HomeScreen/homescreen.dart';
import 'package:flutter_books/view/splashScreen/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.ralewayTextTheme(
            Theme.of(context)
                .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
          ),
        ),
        home: FutureBuilder(
            future: getFlag(),
            builder: (context, snapshot) {
              if (snapshot.data == false) {
                setFlag();
                return AnimatedSplashScreen(
                    splash: 'assets/splash_image.png',
                  splashIconSize: MediaQuery.of(context).size.height,
                  nextScreen: HomeScreen(),
                  splashTransition: SplashTransition.fadeTransition,
                );
              } else {
                return AnimatedSplashScreen(
                  splash: 'assets/splash_image.png',
                  splashIconSize: MediaQuery.of(context).size.height,
                  nextScreen: HomeScreen(),
                  splashTransition: SplashTransition.fadeTransition,
                );
              }
            }));
  }
}

Future<bool> getFlag() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getBool("visited") ?? false;
}

setFlag() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setBool('visited', true);
}

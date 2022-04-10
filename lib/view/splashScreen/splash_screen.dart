import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_books/model/splash_page_data.dart';
import 'package:flutter_books/view/splashScreen/widgets/page_card.dart';

import '../HomeScreen/homescreen.dart';



class SplashScreen extends StatelessWidget {
  final List<PageData> pages = [
    PageData(
      image: "assets/splash_1.png",
      title: "Books from \nall genres",
      textColor: Colors.white,
      bgColor: Color(0xFFFDBFDD),
    ),
    PageData(
      image: "assets/splash_2.gif",
      title: "Read \nNonstop",
      bgColor: Color(0xFFFFFFFF),
    ),
    PageData(
      image: "assets/splash_3.png",
      title: "Explore \npopular authors",
      bgColor: Color(0xfffffdaf),
      textColor: Colors.white,
    ),
  ];

  List<Color> get colors => pages.map((p) => p.bgColor).toList();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ConcentricPageView(
          onFinish: () {
            Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
          },
          colors: colors,
          radius: 30,
          curve: Curves.ease,
          duration: Duration(seconds: 2),
          itemBuilder: (index, value) {
            PageData page = pages[index % pages.length];
            // For example scale or transform some widget by [value] param
            //            double scale = (1 - (value.abs() * 0.4)).clamp(0.0, 1.0);
            if (index >= pages.length) {
              Future.delayed(const Duration(milliseconds: 100), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              });
            }

            return Container(
              child: Theme(
                data: ThemeData(
                  textTheme: TextTheme(
                    headline6: TextStyle(
                      color: page.textColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Helvetica',
                      letterSpacing: 0.0,
                      fontSize: 17,
                    ),
                    subtitle2: TextStyle(
                      color: page.textColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                ),
                child: PageCard(page: page),
              ),
            );
          },
        ),
      ),
    );
  }
}

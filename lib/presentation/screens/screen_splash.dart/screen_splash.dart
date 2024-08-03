import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/core/colors.dart';
import 'package:news_app/presentation/screens/main_page/mainpage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ScreenMainPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/channels4_profile.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'KUMUDAM NEWS',
              style: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 154, 40, 31),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            LoadingAnimationWidget.prograssiveDots(color: kredcolor, size: 40),
          ],
        ),
      ),
    );
  }
}

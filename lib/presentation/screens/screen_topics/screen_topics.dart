import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ScreenTopics extends StatelessWidget {
  const ScreenTopics({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.red, size: 40),
              ),
    );
  }
}
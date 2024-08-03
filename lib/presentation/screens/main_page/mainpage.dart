import 'package:flutter/material.dart';

import 'package:news_app/presentation/screens/Screen_settings/screen_settings.dart';
import 'package:news_app/presentation/screens/home_page/screen_homepage.dart';
import 'package:news_app/presentation/screens/main_page/bottom_nav.dart';
import 'package:news_app/presentation/screens/screen_livetv/screen_livetv.dart';
import 'package:news_app/presentation/screens/screen_topics/screen_topics.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({super.key});
  final _pages = [
    const ScreenHomepage(),
    const ScreenLivetv(),
    const ScreenTopics(),
    const ScreenSettings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: indexChangeNotifier,
            builder: (context, int index, _) {
              return _pages[index];
            }),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}

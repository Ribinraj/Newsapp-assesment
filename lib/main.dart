import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/presentation/bloc/bloc/fetch_news_bloc.dart';


import 'package:news_app/presentation/screens/screen_splash.dart/screen_splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchNewsBloc(),
      child: MaterialApp(
        title: 'KUMUDAM NEWS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData( primarySwatch: Colors.grey),
        home:SplashScreen(),
      ),
    );
  }
}

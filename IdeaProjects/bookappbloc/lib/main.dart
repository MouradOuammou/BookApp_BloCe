import 'package:flutter/material.dart';

import 'blocs/bloc_providers.dart';
import 'pages/favorites_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProviders(
        child: const HomePage(),
      ),
      routes: {
        '/favorites': (context) => const FavoritesPage(),
      },
    );
  }
}
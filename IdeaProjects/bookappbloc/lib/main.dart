import 'package:bookappbloc/pages/favorites_page.dart';
import 'package:bookappbloc/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'blocs/bloc_providers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProviders(
        child: HomePage(),
      ),
      routes: {
        '/favorites': (context) => FavoritesPage(),
      },
    );
  }
}
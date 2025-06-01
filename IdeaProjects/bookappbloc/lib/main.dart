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
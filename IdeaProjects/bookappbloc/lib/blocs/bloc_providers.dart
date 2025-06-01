class BlocProviders extends StatelessWidget {
  final Widget child;

  BlocProviders({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookBloc(
            BookRepository(httpClient: http.Client()),
          ),
        ),
        BlocProvider(
          create: (context) => FavoriteBloc(
            FavoriteRepository(dbService: DbService()),
          )..add(LoadFavorites()),
        ),
      ],
      child: child,
    );
  }
}
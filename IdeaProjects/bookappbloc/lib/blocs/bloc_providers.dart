import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/book_repository.dart';
import '../data/repositories/favorite_repository.dart';
import 'book_bloc.dart';
import 'favorite_bloc.dart';

class BlocProviders extends StatelessWidget {
  final Widget child;

  const BlocProviders({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ApiService(httpClient: http.Client()),
        ),
        RepositoryProvider(
          create: (context) => DbService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BookBloc(
              BookRepository(
                apiService: RepositoryProvider.of<ApiService>(context),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => FavoriteBloc(
              FavoriteRepository(
                dbService: RepositoryProvider.of<DbService>(context),
              ),
            )..add(LoadFavorites()),
          ),
        ],
        child: child,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../data/repositories/book_repository.dart';
import '../data/repositories/favorite_repository.dart';
import '../data/services/api_service.dart';
import '../data/services/db_service.dart';
import 'book_bloc.dart';
import 'favorite_bloc.dart';
import 'favorite_event.dart';

class BlocProviders extends StatelessWidget {
  final Widget child;

  const BlocProviders({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // Services
        RepositoryProvider(
          create: (context) => ApiService(httpClient: http.Client()),
        ),
        RepositoryProvider(
          create: (context) => DbService(),
        ),
        // ✅ AJOUT: Repositories en tant que providers
        RepositoryProvider(
          create: (context) => BookRepository(
            apiService: RepositoryProvider.of<ApiService>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => FavoriteRepository(
            dbService: RepositoryProvider.of<DbService>(context),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BookBloc(
              RepositoryProvider.of<BookRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => FavoriteBloc(
              RepositoryProvider.of<FavoriteRepository>(context),
            )..add(LoadFavorites()),
          ),
        ],
        child: child,
      ),
    );
  }
}
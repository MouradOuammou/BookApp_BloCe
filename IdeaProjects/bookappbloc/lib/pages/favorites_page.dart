import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/favorite_bloc.dart';
import '../blocs/favorite_event.dart';
import '../blocs/favorite_state.dart';
import '../widgets/book_list.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoris')),
      body: BlocConsumer<FavoriteBloc, FavoriteState>(
        listener: (context, state) {
          if (state is FavoriteError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoriteLoaded) {
            return state.books.isEmpty
                ? const Center(child: Text('Aucun favori'))
                : BookList(
              books: state.books,
              favoriteStatuses: {for (var book in state.books) book.id: true},
              onToggleFavorite: (book) {
                context.read<FavoriteBloc>().add(
                  ToggleFavorite(book, true),
                );
              },
            );
          } else if (state is FavoriteUpdated) {
            return BookList(
              books: state.books,
              favoriteStatuses: {for (var book in state.books) book.id: true},
              onToggleFavorite: (book) {
                context.read<FavoriteBloc>().add(
                  ToggleFavorite(book, true),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
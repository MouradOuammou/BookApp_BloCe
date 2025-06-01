import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/book_bloc.dart';
import '../blocs/book_event.dart';
import '../blocs/book_state.dart';
import '../blocs/favorite_bloc.dart';
import '../blocs/favorite_event.dart';
import '../blocs/favorite_state.dart';
import '../widgets/book_list.dart';
import '../widgets/search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Search')),
      body: Column(
        children: [
          SearchBar(
            onSearch: (query) {
              context.read<BookBloc>().add(SearchBooks(query));
            },
            onClear: () {
              context.read<BookBloc>().add(SearchBooks(''));
            },
          ),
          Expanded(
            child: BlocBuilder<BookBloc, BookState>(
              builder: (context, state) {
                if (state is BookInitial) {
                  return const Center(child: Text('Recherchez un livre'));
                } else if (state is BookLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BookError) {
                  return Center(child: Text(state.message));
                } else if (state is BookLoaded) {
                  return BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, favState) {
                      final favoriteStatuses = favState is FavoriteLoaded
                          ? {for (var book in favState.books) book.id: true}
                          : <String, bool>{};

                      return BookList(
                        books: state.books,
                        favoriteStatuses: favoriteStatuses,
                        onToggleFavorite: (book) {
                          final isFavorite = favoriteStatuses[book.id] ?? false;
                          context.read<FavoriteBloc>().add(
                            ToggleFavorite(book, isFavorite),
                          );
                        },
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/favorites');
        },
        child: const Icon(Icons.favorite),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/book_bloc.dart';
import '../blocs/book_state.dart';
import '../blocs/favorite_bloc.dart';
import '../blocs/favorite_event.dart';
import '../blocs/favorite_state.dart';
import '../data/models/book.dart';

class BookDetailPage extends StatelessWidget {
  final String bookId;

  const BookDetailPage({Key? key, required this.bookId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détails du livre')),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookDetailLoaded) {
            final book = state.book;
            return _buildDetailView(book, context);
          } else if (state is BookError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildDetailView(Book book, BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (book.imageUrl.isNotEmpty)
            Center(
              child: Image.network(
                book.imageUrl,
                height: 300,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 300,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.book,
                      size: 100,
                      color: Colors.grey,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 20),
          Text(
            book.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          Text(
            'Auteur: ${book.author}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, favoriteState) {
              bool isFavorite = false;
              if (favoriteState is FavoriteLoaded) {
                isFavorite = favoriteState.books.any((fav) => fav.id == book.id);
              } else if (favoriteState is FavoriteUpdated) {
                isFavorite = favoriteState.books.any((fav) => fav.id == book.id);
              }

              return ElevatedButton.icon(
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                label: Text(isFavorite ? 'Retirer des favoris' : 'Ajouter aux favoris'),
                onPressed: () {
                  context.read<FavoriteBloc>().add(
                    ToggleFavorite(book, isFavorite),
                  );
                },
              );
            },
          ),
          const SizedBox(height: 20),
          // Informations supplémentaires
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informations',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  Text('ID: ${book.id}'),
                  if (book.imageUrl.isNotEmpty)
                    const Text('Image disponible')
                  else
                    const Text('Aucune image disponible'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
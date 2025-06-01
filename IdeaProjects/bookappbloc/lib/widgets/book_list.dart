import 'package:flutter/material.dart';

import '../data/models/book.dart';
import 'book_card.dart';

class BookList extends StatelessWidget {
  final List<Book> books;
  final Map<String, bool>? favoriteStatuses;
  final Function(Book)? onToggleFavorite;

  const BookList({
    Key? key,
    required this.books,
    this.favoriteStatuses,
    this.onToggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        final isFavorite = favoriteStatuses?[book.id] ?? false;

        return BookCard(
          book: book,
          isFavorite: isFavorite,
          onFavoriteToggle: onToggleFavorite != null
              ? () => onToggleFavorite!(book)
              : null,
        );
      },
    );
  }
}
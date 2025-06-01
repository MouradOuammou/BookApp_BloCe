import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/book_bloc.dart';
import '../blocs/book_event.dart';
import '../data/models/book.dart';
import '../pages/book_detail_page.dart';
import 'favorite_button.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const BookCard({
    Key? key,
    required this.book,
    this.isFavorite = false,
    this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {
          context.read<BookBloc>().add(LoadBookDetails(book.id));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailPage(bookId: book.id),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: book.imageUrl.isNotEmpty
                  ? Image.network(
                book.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
              )
                  : _buildPlaceholder(),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (onFavoriteToggle != null)
                    FavoriteButton(
                      book: book,
                      isFavorite: isFavorite,
                      onStateChanged: (newState) => onFavoriteToggle?.call(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Icon(Icons.book, size: 40, color: Colors.grey[400]),
      ),
    );
  }
}
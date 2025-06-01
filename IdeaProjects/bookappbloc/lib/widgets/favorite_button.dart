import 'package:flutter/material.dart';

import '../data/models/book.dart';

class FavoriteButton extends StatelessWidget {
  final Book book;
  final bool isFavorite;
  final Function(bool)? onStateChanged;

  const FavoriteButton({
    Key? key,
    required this.book,
    required this.isFavorite,
    this.onStateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: () {
        onStateChanged?.call(!isFavorite);
      },
    );
  }
}
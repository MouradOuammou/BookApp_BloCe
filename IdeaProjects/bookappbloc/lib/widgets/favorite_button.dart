import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/favorite_event.dart';
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
        if (onStateChanged != null) {
          onStateChanged!(!isFavorite);
        } else {
          // Gestion par défaut avec le BLoC
          context.read<FavoriteBloc>().add(
            ToggleFavorite(book, isFavorite),
          );
        }
      },
    );
  }
}
import '../../data/models/book.dart';

abstract class FavoriteEvent {}

class LoadFavorites extends FavoriteEvent {}

class AddFavorite extends FavoriteEvent {
  final Book book;

  AddFavorite(this.book);
}

class RemoveFavorite extends FavoriteEvent {
  final String bookId;

  RemoveFavorite(this.bookId);
}

class ToggleFavorite extends FavoriteEvent {
  final Book book;
  final bool isFavorite;

  ToggleFavorite(this.book, this.isFavorite);
}
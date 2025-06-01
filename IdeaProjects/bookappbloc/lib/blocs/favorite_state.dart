abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<Book> books;

  FavoriteLoaded(this.books);
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);
}

class FavoriteUpdated extends FavoriteState {
  final List<Book> books;
  final bool isAdded;

  FavoriteUpdated(this.books, this.isAdded);
}
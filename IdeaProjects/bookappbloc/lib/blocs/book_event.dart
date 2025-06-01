abstract class BookEvent {}

class SearchBooks extends BookEvent {
  final String query;

  SearchBooks(this.query);
}
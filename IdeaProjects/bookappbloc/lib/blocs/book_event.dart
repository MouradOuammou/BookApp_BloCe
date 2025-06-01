abstract class BookEvent {}

class SearchBooks extends BookEvent {
  final String query;

  SearchBooks(this.query);
}

class LoadBookDetails extends BookEvent {
  final String bookId;

  LoadBookDetails(this.bookId);
}
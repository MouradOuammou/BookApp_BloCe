  import '../../data/models/book.dart';

  abstract class BookState {}

  class BookInitial extends BookState {}

  class BookLoading extends BookState {}

  class BookLoaded extends BookState {
    final List<Book> books;

    BookLoaded(this.books);
  }

  class BookDetailLoaded extends BookState {
    final Book book;

    BookDetailLoaded(this.book);
  }

  class BookError extends BookState {
    final String message;

    BookError(this.message);
  }
import 'package:bloc/bloc.dart';

import '../../data/repositories/book_repository.dart';
import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository bookRepository;

  BookBloc(this.bookRepository) : super(BookInitial()) {
    on<SearchBooks>((event, emit) async {
      emit(BookLoading());
      try {
        final books = await bookRepository.searchBooks(event.query);
        emit(BookLoaded(books));
      } catch (e) {
        emit(BookError(e.toString()));
      }
    });

    on<LoadBookDetails>((event, emit) async {
      emit(BookLoading());
      try {
        final book = await bookRepository.getBookDetails(event.bookId);
        emit(BookDetailLoaded(book));
      } catch (e) {
        emit(BookError(e.toString()));
      }
    });
  }
}
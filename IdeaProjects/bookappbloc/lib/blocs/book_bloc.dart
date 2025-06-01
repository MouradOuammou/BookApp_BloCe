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
  }
}
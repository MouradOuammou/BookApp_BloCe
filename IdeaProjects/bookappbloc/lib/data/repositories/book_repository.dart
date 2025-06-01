import '../models/book.dart';
import '../services/api_service.dart';

class BookRepository {
  final ApiService apiService;

  BookRepository({required this.apiService});

  Future<List<Book>> searchBooks(String query) async {
    return await apiService.searchBooks(query);
  }

  Future<Book> getBookDetails(String bookId) async {
    return await apiService.getBookDetails(bookId);
  }
}
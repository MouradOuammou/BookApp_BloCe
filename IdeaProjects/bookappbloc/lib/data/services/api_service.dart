import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class ApiService {
  static const String _baseUrl = 'https://www.googleapis.com/books/v1';
  final http.Client httpClient;

  ApiService({required this.httpClient});

  Future<List<Book>> searchBooks(String query) async {
    final response = await httpClient.get(
      Uri.parse('$_baseUrl/volumes?q=$query&maxResults=20'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['items'] as List? ?? [];
      return items.map((item) => Book.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load books: ${response.statusCode}');
    }
  }

  Future<Book> getBookDetails(String bookId) async {
    final response = await httpClient.get(
      Uri.parse('$_baseUrl/volumes/$bookId'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Book.fromJson(data);
    } else {
      throw Exception('Failed to load book details');
    }
  }
}
class BookRepository {
  final http.Client httpClient;

  BookRepository({required this.httpClient});

  Future<List<Book>> searchBooks(String query) async {
    final response = await httpClient.get(
      Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final items = data['items'] as List;
      return items.map((item) => Book.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
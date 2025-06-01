class FavoriteRepository {
  final DbService dbService;

  FavoriteRepository({required this.dbService});

  Future<List<Book>> getFavorites() async {
    final favorites = await dbService.getItems();
    return favorites.map((map) => Book.fromMap(map)).toList();
  }

  Future<void> addFavorite(Book book) async {
    await dbService.insertItem(book.toMap());
  }

  Future<void> removeFavorite(String bookId) async {
    await dbService.deleteItem(bookId);
  }

  Future<bool> isFavorite(String bookId) async {
    final favorites = await getFavorites();
    return favorites.any((book) => book.id == bookId);
  }
}
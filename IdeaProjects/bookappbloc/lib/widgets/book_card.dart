class BookCard extends StatelessWidget {
  final Book book;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const BookCard({
    Key? key,
    required this.book,
    this.isFavorite = false,
    this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {
          context.read<BookBloc>().add(LoadBookDetails(book.id));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailPage(bookId: book.id),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Partie image avec placeholder si imageUrl est vide
            Expanded(
              child: book.imageUrl.isNotEmpty
                  ? Image.network(
                book.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
              )
                  : _buildPlaceholder(),
            ),
            // Partie texte
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    book.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Bouton favori avec gestion externe
                  if (onFavoriteToggle != null)
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                      onPressed: onFavoriteToggle,
                      iconSize: 20,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Icon(Icons.book, size: 40, color: Colors.grey[400]),
      ),
    );
  }
}
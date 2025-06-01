class BookDetailPage extends StatelessWidget {
  final String bookId;

  const BookDetailPage({Key? key, required this.bookId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détails du livre')),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookDetailLoaded) {
            final book = state.book;
            return _buildDetailView(book, context);
          } else if (state is BookError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildDetailView(Book book, BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (book.imageUrl.isNotEmpty)
            Center(
              child: Image.network(
                book.imageUrl,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
          const SizedBox(height: 20),
          Text(
            book.title,
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 10),
          Text(
            'Auteur: ${book.author}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(height: 20),
          BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              return FutureBuilder<bool>(
                future: context.read<FavoriteRepository>().isFavorite(book.id),
                builder: (context, snapshot) {
                  final isFavorite = snapshot.data ?? false;
                  return ElevatedButton.icon(
                    icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                    label: Text(isFavorite ? 'Retirer des favoris' : 'Ajouter aux favoris'),
                    onPressed: () {
                      context.read<FavoriteBloc>().add(
                        ToggleFavorite(book, isFavorite),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
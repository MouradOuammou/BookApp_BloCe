class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favoris')),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FavoriteLoaded) {
            return state.books.isEmpty
                ? Center(child: Text('Aucun favori'))
                : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                return BookCard(
                  book: state.books[index],
                  isFavorite: true,
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
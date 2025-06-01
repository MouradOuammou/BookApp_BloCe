import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/favorite_state.dart';
import '../widgets/book_card.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/book_bloc.dart';
import '../blocs/book_state.dart';
import '../widgets/book_list.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Search')),
      body: Column(
        children: [
          SearchBar(),
          Expanded(
            child: BlocBuilder<BookBloc, BookState>(
              builder: (context, state) {
                if (state is BookInitial) {
                  return Center(child: Text('Recherchez un livre'));
                } else if (state is BookLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is BookError) {
                  return Center(child: Text(state.message));
                } else if (state is BookLoaded) {
                  return BookList(books: state.books);
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
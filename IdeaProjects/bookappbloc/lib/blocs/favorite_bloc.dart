import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/book.dart';
import '../../data/repositories/favorite_repository.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository favoriteRepository;

  FavoriteBloc(this.favoriteRepository) : super(FavoriteInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddFavorite>(_onAddFavorite);
    on<RemoveFavorite>(_onRemoveFavorite);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(
      LoadFavorites event,
      Emitter<FavoriteState> emit,
      ) async {
    emit(FavoriteLoading());
    try {
      final favorites = await favoriteRepository.getFavorites();
      emit(FavoriteLoaded(favorites));
    } catch (e) {
      emit(FavoriteError('Failed to load favorites: ${e.toString()}'));
    }
  }

  Future<void> _onAddFavorite(
      AddFavorite event,
      Emitter<FavoriteState> emit,
      ) async {
    if (state is FavoriteLoaded) {
      final currentState = state as FavoriteLoaded;
      try {
        await favoriteRepository.addFavorite(event.book);
        final updatedFavorites = await favoriteRepository.getFavorites();
        emit(FavoriteUpdated(updatedFavorites, true));
      } catch (e) {
        emit(FavoriteError('Failed to add favorite: ${e.toString()}'));
        emit(currentState); // Revert to previous state
      }
    }
  }

  Future<void> _onRemoveFavorite(
      RemoveFavorite event,
      Emitter<FavoriteState> emit,
      ) async {
    if (state is FavoriteLoaded) {
      final currentState = state as FavoriteLoaded;
      try {
        await favoriteRepository.removeFavorite(event.bookId);
        final updatedFavorites = await favoriteRepository.getFavorites();
        emit(FavoriteUpdated(updatedFavorites, false));
      } catch (e) {
        emit(FavoriteError('Failed to remove favorite: ${e.toString()}'));
        emit(currentState); // Revert to previous state
      }
    }
  }

  Future<void> _onToggleFavorite(
      ToggleFavorite event,
      Emitter<FavoriteState> emit,
      ) async {
    if (event.isFavorite) {
      add(RemoveFavorite(event.book.id));
    } else {
      add(AddFavorite(event.book));
    }
  }
}
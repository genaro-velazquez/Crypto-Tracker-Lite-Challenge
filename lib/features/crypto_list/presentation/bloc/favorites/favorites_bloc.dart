import 'package:crypto_tracker_lite/features/crypto_list/data/services/favorites_service.dart';
import 'package:crypto_tracker_lite/features/crypto_list/domain/repositories/crypto_repository.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/favorites/favorites_event.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/favorites/favorites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final CryptoRepository repository;
  final FavoritesService favoritesService;

  FavoritesBloc({required this.repository, required this.favoritesService})
    : super(const FavoritesInitial()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<AddFavoriteEvent>(_onAddFavorite);
    on<RemoveFavoriteEvent>(_onRemoveFavorite);
    on<RefreshFavoritesEvent>(_onRefreshFavorites);
  }

  Future<void> _onLoadFavorites(
    LoadFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesLoading());

    try {
      final favoriteIds = favoritesService.getFavoriteIds();

      if (favoriteIds.isEmpty) {
        emit(const FavoritesEmpty());
        return;
      }

      // Cargar detalles de cada favorito
      final favorites = <dynamic>[];
      for (final id in favoriteIds) {
        try {
          final crypto = await repository.getCryptoDetails(id);
          final updated = crypto.copyWith(isFavorite: true);
          favorites.add(updated);
        } catch (e) {
          // Ignorar si no se puede cargar
        }
      }

      if (favorites.isEmpty) {
        emit(const FavoritesEmpty());
      } else {
        emit(FavoritesLoaded(favorites: List.from(favorites)));
      }
    } catch (e) {
      emit(FavoritesError(message: e.toString()));
    }
  }

  Future<void> _onAddFavorite(
    AddFavoriteEvent event, 
    Emitter<FavoritesState> emit,
  ) async {
    try{  
      await favoritesService.addFavorite(event.cryptoId); 
      // Recargar favoritos
      add(const LoadFavoritesEvent());
    }catch (e){
      emit(FavoritesError(message: e.toString()));
    }
  }

  Future<void> _onRemoveFavorite(
    RemoveFavoriteEvent event, 
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await favoritesService.removeFavorite(event.cryptoId);
      // Recargar favoritos
      add(const LoadFavoritesEvent());
    } catch (e) {
      emit(FavoritesError(message: e.toString()));
    }
  }

  Future<void> _onRefreshFavorites(
    RefreshFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    add(const LoadFavoritesEvent());
  }

}

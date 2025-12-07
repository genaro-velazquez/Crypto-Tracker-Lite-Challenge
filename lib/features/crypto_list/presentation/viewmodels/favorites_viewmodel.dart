


import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/favorites/favorites_event.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/favorites/favorites_state.dart';

class FavoritesViewModel {
  final FavoritesBloc bloc;

  FavoritesViewModel({required this.bloc}); 

    void loadFavorites() {
    bloc.add(const LoadFavoritesEvent());
  }

  void removeFavorite(String cryptoId) {
    bloc.add(RemoveFavoriteEvent(cryptoId: cryptoId));
  }

  void refreshFavorites() {
    bloc.add(const RefreshFavoritesEvent());
  }

  FavoritesState get currentState => bloc.state;

  Stream<FavoritesState> get stateStream => bloc.stream;

}
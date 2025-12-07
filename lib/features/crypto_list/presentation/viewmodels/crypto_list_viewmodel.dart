import 'package:crypto_tracker_lite/features/crypto_list/domain/entities/crypto_entity.dart';
import 'package:crypto_tracker_lite/features/crypto_list/domain/repositories/crypto_repository.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/crypto_list/crypto_list_bloc.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/crypto_list/crypto_list_event.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/crypto_list/crypto_list_state.dart';

class CryptoListViewModel {
  final CryptoListBloc bloc;
  final CryptoRepository repository;

  CryptoListViewModel({required this.bloc, required this.repository});

  // Métodos que expone el ViewModel

  void loadCryptos({int page = 1}) {
    bloc.add(GetCryptoListEvent(page: page));
  }

  void refreshCryptos() {
    bloc.add(const RefreshCryptoListEvent());
  }

  Future<void> toggleFavorite(String cryptoId, bool isFavorite) async {
    try {
      // Obtener estado actual del BLoC
      if (bloc.state is CryptoListLoaded) {
        final state = bloc.state as CryptoListLoaded;

        // Encontrar la cripto en la lista
        final cryptoIndex = state.cryptos.indexWhere((c) => c.id == cryptoId);

        if (cryptoIndex != -1) {
          final crypto = state.cryptos[cryptoIndex];

          // Toggle en el repository
          await repository.toggleFavorite(crypto);

          // Actualizar la cripto localmente
          final updatedCrypto = crypto.copyWith(isFavorite: !crypto.isFavorite);

          // Actualizar la lista en el estado
          final updatedCryptos = List<CryptoEntity>.from(state.cryptos);
          updatedCryptos[cryptoIndex] = updatedCrypto;

          // Emitir nuevo estado
          bloc.emit(
            CryptoListLoaded(
              cryptos: updatedCryptos,
              currentPage: state.currentPage,
            ),
          );
        }
      }
    } catch (e) {
      // Error silencioso
    }
  }

  void loadMoreCryptos(int nextPage) {
    bloc.add(GetCryptoListEvent(page: nextPage));
  }

  // Acceso al estado actual
  CryptoListState get currentState => bloc.state;

  // Stream de estados
  Stream<CryptoListState> get stateStream => bloc.stream;
}

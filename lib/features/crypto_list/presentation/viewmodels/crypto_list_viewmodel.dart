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


/*
class CryptoListViewModel {
    // Estado
  List<CryptoEntity> cryptos = [];
  bool isLoading = false;
  String? errorMessage;
  int currentPage = 1;

    // Datos Mock (por ahora, sin API)
  static final List<CryptoEntity> mockCryptos = [
    CryptoEntity(
      id: 'bitcoin',
      name: 'Bitcoin',
      symbol: 'btc',
      image: 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png',
      currentPrice: 91234.50,
      high24h: 92000.00,
      low24h: 89500.00,
      priceChangePercentage24h: 2.45,
      marketCap: 1800000000000,
      marketCapRank: 1,
      isFavorite: false,
    ),
    CryptoEntity(
      id: 'ethereum',
      name: 'Ethereum',
      symbol: 'eth',
      image: 'https://assets.coingecko.com/coins/images/279/large/ethereum.png',
      currentPrice: 3421.75,
      high24h: 3500.00,
      low24h: 3350.00,
      priceChangePercentage24h: 1.80,
      marketCap: 412000000000,
      marketCapRank: 2,
      isFavorite: false,
    ),
    CryptoEntity(
      id: 'cardano',
      name: 'Cardano',
      symbol: 'ada',
      image: 'https://assets.coingecko.com/coins/images/975/large/cardano.png',
      currentPrice: 0.98,
      high24h: 1.05,
      low24h: 0.92,
      priceChangePercentage24h: -1.20,
      marketCap: 35000000000,
      marketCapRank: 9,
      isFavorite: false,
    ),
    CryptoEntity(
      id: 'solana',
      name: 'Solana',
      symbol: 'sol',
      image: 'https://assets.coingecko.com/coins/images/4128/large/solana.png',
      currentPrice: 189.45,
      high24h: 195.00,
      low24h: 185.00,
      priceChangePercentage24h: 3.50,
      marketCap: 88000000000,
      marketCapRank: 5,
      isFavorite: false,
    ),
    CryptoEntity(
      id: 'ripple',
      name: 'XRP',
      symbol: 'xrp',
      image: 'https://assets.coingecko.com/coins/images/44/large/xrp.png',
      currentPrice: 2.15,
      high24h: 2.25,
      low24h: 2.10,
      priceChangePercentage24h: 0.75,
      marketCap: 120000000000,
      marketCapRank: 6,
      isFavorite: false,
    ),
  ];

  // Métodos
  Future<void> loadCryptos() async {
    isLoading = true;
    errorMessage = null;
  
    // Simular delay de red
    await Future.delayed(const Duration(milliseconds: 800));
  
    cryptos = List.from(mockCryptos);
    isLoading = false;
    currentPage = 1;
  }

  Future<void> refreshCryptos() async {
    await loadCryptos();
  }

  void toggleFavorite(CryptoEntity crypto) {
    final index = cryptos.indexWhere((c) => c.id == crypto.id);
    if (index != -1) {
      cryptos[index] = cryptos[index].copyWith(
        isFavorite: !cryptos[index].isFavorite,
      );
    }
  }


  void setError(String message) {
    errorMessage = message;
    isLoading = false;
  }


}
*/
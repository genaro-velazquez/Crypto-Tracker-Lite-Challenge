

import 'package:bloc/bloc.dart';
import 'package:crypto_tracker_lite/features/crypto_list/domain/repositories/crypto_repository.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/crypto_list/crypto_list_event.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/crypto_list/crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  final CryptoRepository repository;

  CryptoListBloc({required this.repository})
      : super(const CryptoListInitial()) {
    // Registrar handlers
    on<GetCryptoListEvent>(_onGetCryptoList);
    on<RefreshCryptoListEvent>(_onRefreshCryptoList);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  List<dynamic> _allCryptos = [];
  int _currentPage = 1;

  // Handler: Obtener lista de criptos
  Future<void> _onGetCryptoList(
    GetCryptoListEvent event,
    Emitter<CryptoListState> emit,
  ) async {
    // Si es la primera página, mostrar loading
    if (event.page == 1) {
      emit(const CryptoListLoading());
    }

    try {
      // Llamar al repository
      final cryptos = await repository.getMarkets(page: event.page);

      // Si es primera página, reemplazar; si no, agregar
      if (event.page == 1) {
        _allCryptos = cryptos;
      } else {
        _allCryptos.addAll(cryptos);
      }

      _currentPage = event.page;

      emit(CryptoListLoaded(
        cryptos: List.from(_allCryptos),
        currentPage: _currentPage,
      ));
    } on Exception catch (e) {
      // Detectar error 429 (Rate Limit)
      if (e.toString().contains('429')) {
        emit(const CryptoListRateLimitError(
          message: 'Límite de peticiones excedido. Por favor espera.',
        ));
      } else {
        emit(CryptoListError(message: e.toString()));
      }
    }
  }

  // Handler: Refrescar
  Future<void> _onRefreshCryptoList(
    RefreshCryptoListEvent event,
    Emitter<CryptoListState> emit,
  ) async {
    // Resetear y cargar desde página 1
    _allCryptos = [];
    _currentPage = 1;
    add(const GetCryptoListEvent(page: 1));
  }

  // Handler: Toggle Favorito
  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<CryptoListState> emit,
  ) async {
    try {
      // Aquí irá la lógica de favoritos (más adelante)
      // Por ahora solo es un placeholder
    } catch (e) {
      emit(CryptoListError(message: e.toString()));
    }
  }
}

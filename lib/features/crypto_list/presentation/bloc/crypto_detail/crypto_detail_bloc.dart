import 'package:crypto_tracker_lite/features/crypto_list/domain/entities/market_data_entity.dart';
import 'package:crypto_tracker_lite/features/crypto_list/domain/repositories/crypto_repository.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/crypto_detail/crypto_detail_event.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/crypto_detail/crypto_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoDetailBloc extends Bloc<CryptoDetailEvent, CryptoDetailState> {
  final CryptoRepository repository;

  CryptoDetailBloc({required this.repository})
    : super(const CryptoDetailInitial()) {
    on<GetCryptoDetailEvent>(_onGetCryptoDetail);
    on<RefreshCryptoDetailEvent>(_onRefreshCryptoDetail);
  }

  Future<void> _onGetCryptoDetail(
    GetCryptoDetailEvent event,
    Emitter<CryptoDetailState> emit,
  ) async {
    emit(const CryptoDetailLoading());

    try {
      // Cargar detalles de la cripto
      final crypto = await repository.getCryptoDetails(event.cryptoId);

      // Cargar gráfico
      MarketDataEntity? chartData;
      try {
        chartData = await repository.getMarketChart(event.cryptoId);
      } catch (e) {
        // Log del error para debuggear
        print('❌ Error cargando gráfico: $e');
        chartData = null;
      }

      emit(CryptoDetailLoaded(crypto: crypto, chartData: chartData));
    } on Exception catch (e) {
      emit(CryptoDetailError(message: e.toString()));
    }
  }

  Future<void> _onRefreshCryptoDetail(
    RefreshCryptoDetailEvent event,
    Emitter<CryptoDetailState> emit,
  ) async {
    add(GetCryptoDetailEvent(cryptoId: event.cryptoId));
  }
}

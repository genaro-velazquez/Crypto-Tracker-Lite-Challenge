import 'package:crypto_tracker_lite/features/crypto_list/data/datasources/crypto_remote_datasource.dart';
import 'package:crypto_tracker_lite/features/crypto_list/data/services/favorites_service.dart';
import 'package:crypto_tracker_lite/features/crypto_list/domain/entities/crypto_entity.dart';
import 'package:crypto_tracker_lite/features/crypto_list/domain/entities/market_data_entity.dart';
import 'package:crypto_tracker_lite/features/crypto_list/domain/repositories/crypto_repository.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final CryptoRemoteDataSource remoteDataSource;
  final FavoritesService favoritesService;

  CryptoRepositoryImpl({
    required this.remoteDataSource,
    required this.favoritesService,
  });

  @override
  Future<List<CryptoEntity>> getMarkets({
    required int page,
    String currency = 'usd',
  }) async {
    try {
      // 1. Llamar al DataSource (obtiene Models)
      final cryptoModels = await remoteDataSource.getMarkets(
        page: page,
        currency: currency,
      );

      // 2. Convertir Models → Entities
      final cryptoEntities = cryptoModels
          .map((model) => model.toEntity())
          .toList();

      // 3. Retornar Entities (Domain)
      return cryptoEntities;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CryptoEntity> getCryptoDetails(String cryptoId) async {
    try {
      // 1. Llamar al DataSource (obtiene Model)
      final cryptoModel = await remoteDataSource.getCryptoDetails(cryptoId);

      // 2. Convertir Model → Entity
      final cryptoEntity = cryptoModel.toEntity();

      // 3. Retornar Entity (Domain)
      return cryptoEntity;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CryptoEntity>> getFavorites() async {
    try {
      final favoriteIds = favoritesService.getFavoriteIds();

      if (favoriteIds.isEmpty) {
        return [];
      }

      List<CryptoEntity> favorites = [];
      for (String id in favoriteIds) {
        try {
          final crypto = await getCryptoDetails(id);
          favorites.add(crypto.copyWith(isFavorite: true));
        } catch (e) {
          continue;
        }
      }
      return favorites;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> toggleFavorite(CryptoEntity crypto) async {
    try {
      final isFav = favoritesService.isFavorite(crypto.id);

      if (isFav) {
        await favoritesService.removeFavorite(crypto.id);
      } else {
        await favoritesService.addFavorite(crypto.id);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MarketDataEntity> getMarketChart(String cryptoId) async {
    try {
      final chartData = await remoteDataSource.getMarketChart(cryptoId);

      // Extraer precios y fechas
      final prices = chartData.map((point) => point[1]).toList();
      final timestamps = chartData.map((point) => point[0].toInt()).toList();

      // Convertir timestamps a DateTime
      final dates = timestamps
          .map((ts) => DateTime.fromMillisecondsSinceEpoch(ts.toInt()))
          .toList();

      return MarketDataEntity(prices: prices, dates: dates);
    } catch (e) {
      rethrow;
    }
  }
}

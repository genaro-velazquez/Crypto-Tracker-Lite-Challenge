

import 'package:crypto_tracker_lite/features/crypto_list/domain/entities/crypto_entity.dart';

abstract class CryptoRepository {

  Future<List<CryptoEntity>> getMarkets({
    required int page, 
    String currency = 'usd',
  });

  Future<CryptoEntity> getCryptoDetails(String cryptoId);

  Future<List<CryptoEntity>> getFavorites();

  Future<void> toggleFavorite(CryptoEntity crypto);

}
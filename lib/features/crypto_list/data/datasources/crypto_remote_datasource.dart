import 'dart:convert';

import 'package:crypto_tracker_lite/config/constants/api_constants.dart';
import 'package:crypto_tracker_lite/features/crypto_list/data/models/crypto_model.dart';
import 'package:http/http.dart' as http;

abstract class CryptoRemoteDataSource {
  Future<List<CryptoModel>> getMarkets({
    required int page,
    String currency = 'usd',
  });

  Future<CryptoModel> getCryptoDetails(String cryptoId);

  Future<List<List<double>>> getMarketChart(String cryptoId);
}

class CryptoRemoteDataSourceImpl implements CryptoRemoteDataSource {
  final http.Client client;

  CryptoRemoteDataSourceImpl({required this.client});

  // Cache en memoria
  final Map<String, dynamic> _cache = {};
  final Map<String, DateTime> _cacheTime = {};

  bool _isCacheValid(String key) {
    if (!_cacheTime.containsKey(key)) return false;
    final elapsed = DateTime.now().difference(_cacheTime[key]!).inSeconds;
    return elapsed < ApiConstants.cacheTimeoutSeconds;
  }

  @override
  Future<CryptoModel> getCryptoDetails(String cryptoId) async {
    final cacheKey = 'details_$cryptoId';

    // Verificar cache
    if (_isCacheValid(cacheKey)) {
      return _cache[cacheKey] as CryptoModel;
    }

    try {
      final url = ApiConstants.getCryptoDetailsUrl(cryptoId);
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 429) {
        throw Exception('Rate limit exceeded. Please wait a moment.');
      }

      if (response.statusCode != 200) {
        throw Exception('Failed to load crypto details');
      }

      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      // Mapear manualmente para la respuesta de detalle
      final crypto = CryptoModel(
        id: jsonData['id'] as String? ?? '',
        name: jsonData['name'] as String? ?? '',
        symbol: jsonData['symbol'] as String? ?? '',
        image: jsonData['image']?['large'] as String?,
        currentPrice: _extractPrice(jsonData, 'usd'),
        high24h: _extractHighLow(jsonData, 'high_24h'),
        low24h: _extractHighLow(jsonData, 'low_24h'),
        priceChangePercentage24h: _extractChange(jsonData),
        marketCap: _extractMarketCap(jsonData),
        marketCapRank: jsonData['market_cap_rank'] as int?,
      );

      // Guardar en cache
      _cache[cacheKey] = crypto;
      _cacheTime[cacheKey] = DateTime.now();

      return crypto;
    } catch (e) {
      rethrow;
    }
  }

  // Métodos auxiliares para extraer datos del JSON de detalle
  double? _extractPrice(Map<String, dynamic> json, String currency) {
    final marketData = json['market_data'] as Map<String, dynamic>?;
    if (marketData == null) return null;
    final currentPrice = marketData['current_price'] as Map<String, dynamic>?;
    if (currentPrice == null) return null;
    final price = currentPrice[currency];
    if (price is num) return price.toDouble();
    return null;
  }

  double? _extractHighLow(Map<String, dynamic> json, String field) {
    final marketData = json['market_data'] as Map<String, dynamic>?;
    if (marketData == null) return null;
    final fieldData = marketData[field] as Map<String, dynamic>?;
    if (fieldData == null) return null;
    final value = fieldData['usd'];
    if (value is num) return value.toDouble();
    return null;
  }

  double? _extractChange(Map<String, dynamic> json) {
    final marketData = json['market_data'] as Map<String, dynamic>?;
    if (marketData == null) return null;
    final change = marketData['price_change_percentage_24h'];
    if (change is num) return change.toDouble();
    return null;
  }

  double? _extractMarketCap(Map<String, dynamic> json) {
    final marketData = json['market_data'] as Map<String, dynamic>?;
    if (marketData == null) return null;
    final marketCap = marketData['market_cap'] as Map<String, dynamic>?;
    if (marketCap == null) return null;
    final value = marketCap['usd'];
    if (value is num) return value.toDouble();
    return null;
  }

  @override
  Future<List<CryptoModel>> getMarkets({
    required int page,
    String currency = 'usd',
  }) async {
    final cacheKey = 'markets_$page';

    // Verificar cache
    if (_isCacheValid(cacheKey)) {
      return _cache[cacheKey] as List<CryptoModel>;
    }

    try {
      final url = ApiConstants.getMarketsUrl(page: page, currency: currency);
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 429) {
        throw Exception('Rate limit exceeded. Please wait a moment.');
      }

      if (response.statusCode != 200) {
        throw Exception('Failed to load markets');
      }

      final List<dynamic> data = jsonDecode(response.body);
      final cryptos = data
          .map((json) => CryptoModel.fromJson(json as Map<String, dynamic>))
          .toList();

      // Guardar en cache
      _cache[cacheKey] = cryptos;
      _cacheTime[cacheKey] = DateTime.now();

      return cryptos;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<List<double>>> getMarketChart(String cryptoId) async {
    final cacheKey = 'chart_$cryptoId';

    // Verificar cache
    if (_isCacheValid(cacheKey)) {
      return _cache[cacheKey] as List<List<double>>;
    }

    try {
      final url = ApiConstants.getMarketChartUrl(cryptoId);
      final response = await client.get(Uri.parse(url));

      if (response.statusCode == 429) {
        throw Exception('Rate limit exceeded. Please wait a moment.');
      }

      if (response.statusCode != 200) {
        throw Exception('Failed to load market chart');
      }

      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      final prices = jsonData['prices'] as List<dynamic>;

      // Convertir a List<List<double>>
      final chartData = prices
          .map(
            (price) => [
              (price[0] as num).toDouble(),
              (price[1] as num).toDouble(),
            ],
          )
          .toList();

      // Guardar en cache
      _cache[cacheKey] = chartData;
      _cacheTime[cacheKey] = DateTime.now();

      return chartData;
    } catch (e) {
      rethrow;
    }
  }
}

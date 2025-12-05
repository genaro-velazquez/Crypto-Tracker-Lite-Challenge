

import 'dart:convert';

import 'package:crypto_tracker_lite/config/constants/api_constants.dart';
import 'package:crypto_tracker_lite/features/crypto_list/data/models/crypto_model.dart';
import 'package:http/http.dart' as http;

abstract class CryptoRemoteDataSource{
    Future<List<CryptoModel>> getMarkets({
      required int page,
      String currency = 'usd',
    });

    Future<CryptoModel> getCryptoDetails(String cryptoId);
  }

class CryptoRemoteDataSourceImpl implements CryptoRemoteDataSource{

  final http.Client client; 

  CryptoRemoteDataSourceImpl({required this.client});

  // Cache en memoria 
  final Map<String, dynamic> _cache = {};
  final Map<String, DateTime> _cacheTime = {};

  bool _isCacheValid(String key){
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

      final crypto = CryptoModel.fromJson(jsonDecode(response.body));

      // Guardar en cache
      _cache[cacheKey] = crypto;
      _cacheTime[cacheKey] = DateTime.now();

      return crypto;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CryptoModel>> getMarkets({required int page, String currency = 'usd'}) async {
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
  
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoModel _$CryptoModelFromJson(Map<String, dynamic> json) => CryptoModel(
  id: json['id'] as String,
  name: json['name'] as String,
  symbol: json['symbol'] as String,
  image: json['image'] as String?,
  currentPrice: (json['current_price'] as num?)?.toDouble(),
  high24h: (json['high_24h'] as num?)?.toDouble(),
  low24h: (json['low_24h'] as num?)?.toDouble(),
  priceChangePercentage24h: (json['price_change_percentage_24h'] as num?)
      ?.toDouble(),
  marketCap: (json['market_cap'] as num?)?.toDouble(),
  marketCapRank: (json['market_cap_rank'] as num?)?.toInt(),
);

Map<String, dynamic> _$CryptoModelToJson(CryptoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
      'image': instance.image,
      'current_price': instance.currentPrice,
      'high_24h': instance.high24h,
      'low_24h': instance.low24h,
      'price_change_percentage_24h': instance.priceChangePercentage24h,
      'market_cap': instance.marketCap,
      'market_cap_rank': instance.marketCapRank,
    };

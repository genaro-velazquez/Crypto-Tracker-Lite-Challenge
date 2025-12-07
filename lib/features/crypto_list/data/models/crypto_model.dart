
import 'package:crypto_tracker_lite/features/crypto_list/domain/entities/crypto_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_model.g.dart'; 


@JsonSerializable()
class CryptoModel {
  final String id;
  final String name; 
  final String symbol; 
  final String? image;
  @JsonKey(name: 'current_price')
  final double? currentPrice;
  @JsonKey(name: 'high_24h')
  final double? high24h;
  @JsonKey(name: 'low_24h')
  final double? low24h;
  @JsonKey(name: 'price_change_percentage_24h')
  final double? priceChangePercentage24h;
  @JsonKey(name: 'market_cap')
  final double? marketCap;
  @JsonKey(name: 'market_cap_rank')
  final int? marketCapRank;
  final String? description;

  CryptoModel({
    required this.id,
    required this.name, 
    required this.symbol,
    this.image,
    this.currentPrice,
    this.high24h,
    this.low24h,
    this.priceChangePercentage24h,
    this.marketCap,
    this.marketCapRank,
    this.description, 
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) => _$CryptoModelFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoModelToJson(this);

    // Convertir Model a Entity
  CryptoEntity toEntity() {
    return CryptoEntity(
      id: id,
      name: name,
      symbol: symbol,
      image: image,
      currentPrice: currentPrice ?? 0.0,
      high24h: high24h ?? 0.0,
      low24h: low24h ?? 0.0,
      priceChangePercentage24h: priceChangePercentage24h ?? 0.0,
      marketCap: marketCap,
      marketCapRank: marketCapRank,
      description: description,
      isFavorite: false,
    );
  }


}


import 'package:equatable/equatable.dart';

class CryptoEntity extends Equatable{


  final String id; 
  final String name; 
  final String symbol; 
  final String? image; 
  final double currentPrice; 
  final double high24h; 
  final double low24h;
  final double priceChangePercentage24h; 
  final double? marketCap; 
  final int? marketCapRank; 
  final String? description; 
  final bool isFavorite; 

  const CryptoEntity({
    required this.id,
    required this.name,
    required this.symbol,
    this.image,
    required this.currentPrice,
    required this.high24h,
    required this.low24h,
    required this.priceChangePercentage24h,
    this.marketCap,
    this.marketCapRank, 
    this.description,
    this.isFavorite = false
  });
  
  bool get isPositiveChange => priceChangePercentage24h > 0;
  bool get isNegativeChange => priceChangePercentage24h < 0;
  double get absoluteChange => priceChangePercentage24h.abs();

  CryptoEntity copyWith({
    String? id,
    String? name,
    String? symbol,
    String? image, 
    double? currentPrice,
    double? high24h,
    double? low24h,
    double? priceChangePercentage24h,
    double? marketCap,
    int? marketCapRank,
    String? description,
    bool? isFavorite
  }){
    return CryptoEntity(
      id: id ?? this.id, 
      name: name ?? this.name, 
      symbol: symbol ?? this.symbol, 
      image: image ?? this.image,
      currentPrice: currentPrice ?? this.currentPrice, 
      high24h: high24h ?? this.high24h, 
      low24h: low24h ?? this.low24h, 
      priceChangePercentage24h: priceChangePercentage24h ?? this.priceChangePercentage24h,
      marketCap: marketCap ?? this.marketCap,
      marketCapRank: marketCapRank ?? this.marketCapRank,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
    symbol,
    image,
    currentPrice,
    high24h,
    low24h,
    priceChangePercentage24h,
    marketCap,
    marketCapRank,
    description,
    isFavorite,
  ];

}
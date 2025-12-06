

import 'package:crypto_tracker_lite/features/crypto_list/domain/entities/crypto_entity.dart';
import 'package:crypto_tracker_lite/features/crypto_list/domain/entities/market_data_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CryptoDetailState extends Equatable{
  const CryptoDetailState();

  @override
  List<Object?> get props => [];
}

class CryptoDetailInitial extends CryptoDetailState{
  const CryptoDetailInitial();
}

class CryptoDetailLoading extends CryptoDetailState{
  const CryptoDetailLoading();
}

class CryptoDetailLoaded extends CryptoDetailState{
  final CryptoEntity crypto;
  final MarketDataEntity? chartData;


  const CryptoDetailLoaded({required this.crypto,
  this.chartData,});

  @override
  List<Object?> get props => [crypto, chartData];
}

class CryptoDetailError extends CryptoDetailState{
  final String message; 

  const CryptoDetailError({required this.message});

  @override
  List<Object?> get props =>[message];
}



import 'package:crypto_tracker_lite/features/crypto_list/domain/entities/crypto_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CryptoListState extends Equatable {
  const CryptoListState();

  @override
  List<Object?> get props => [];
}

class CryptoListInitial extends CryptoListState {
  const CryptoListInitial();
}

class CryptoListLoading extends CryptoListState {
  const CryptoListLoading();
}

class CryptoListLoaded extends CryptoListState {
  final List<CryptoEntity> cryptos;
  final int currentPage;

  const CryptoListLoaded({
    required this.cryptos,
    required this.currentPage,
  });

  @override
  List<Object?> get props => [cryptos, currentPage];
}

class CryptoListError extends CryptoListState {
  final String message;

  const CryptoListError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CryptoListRateLimitError extends CryptoListState {
  final String message;

  const CryptoListRateLimitError({required this.message});

  @override
  List<Object?> get props => [message];
}

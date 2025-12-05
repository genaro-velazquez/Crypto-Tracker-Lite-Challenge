

import 'package:equatable/equatable.dart';

abstract class CryptoListEvent extends Equatable{

  const CryptoListEvent();

  @override
  List<Object?> get  props => [];
}

class GetCryptoListEvent extends CryptoListEvent {
  final int page;

  const GetCryptoListEvent({this.page = 1});

  @override
  List<Object?> get props => [page];
}

class RefreshCryptoListEvent extends CryptoListEvent {
  const RefreshCryptoListEvent();
}

class ToggleFavoriteEvent extends CryptoListEvent {
  final String cryptoId;
  final bool isFavorite;

  const ToggleFavoriteEvent({
    required this.cryptoId,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [cryptoId, isFavorite];
}


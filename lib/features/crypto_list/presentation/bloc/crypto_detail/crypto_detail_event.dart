

import 'package:equatable/equatable.dart';

abstract class CryptoDetailEvent extends Equatable {

  const CryptoDetailEvent();

  @override
  List<Object?> get props => [];
}

class GetCryptoDetailEvent extends CryptoDetailEvent{
  final String cryptoId; 

  const GetCryptoDetailEvent({required this.cryptoId});

  @override
  List<Object?> get props => [cryptoId];
}

class RefreshCryptoDetailEvent extends CryptoDetailEvent{
    final String cryptoId;

    const RefreshCryptoDetailEvent({required this.cryptoId});

    @override
    List<Object?> get props => [cryptoId];

}
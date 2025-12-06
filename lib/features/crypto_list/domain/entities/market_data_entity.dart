


import 'package:equatable/equatable.dart';

class MarketDataEntity extends Equatable {
  final List<double> prices;
  final List<DateTime> dates;

  const MarketDataEntity({
    required this.prices,
    required this.dates,
  });

  @override
  List<Object?> get props => [prices, dates];
}

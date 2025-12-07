


import 'package:crypto_tracker_lite/features/crypto_list/domain/entities/crypto_entity.dart';
import 'package:equatable/equatable.dart';

abstract class FavoritesState extends Equatable{
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState{
  const FavoritesInitial();
}

class FavoritesLoading extends FavoritesState{
  const FavoritesLoading();
}

class FavoritesLoaded extends FavoritesState{
  final List<CryptoEntity> favorites; 

  const FavoritesLoaded({required this.favorites});

  @override
  List<Object?> get props => [favorites];
}

class FavoritesEmpty extends FavoritesState{
  const FavoritesEmpty();
}

class FavoritesError extends FavoritesState{
  final String message; 

  const FavoritesError({required this.message});

  @override
  List<Object?> get props => [message];
}


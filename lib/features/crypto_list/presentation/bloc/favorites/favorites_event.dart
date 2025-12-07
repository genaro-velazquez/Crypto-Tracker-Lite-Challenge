


import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable{

  const FavoritesEvent();

  @override
  List<Object?> get props => [];  
}

class LoadFavoritesEvent extends FavoritesEvent{
  const LoadFavoritesEvent();
}

class AddFavoriteEvent extends FavoritesEvent{
  final String cryptoId;

  const AddFavoriteEvent({required this.cryptoId});

  @override
  List<Object?> get props => [cryptoId];
}

class RemoveFavoriteEvent extends FavoritesEvent{
  final String cryptoId; 

  const RemoveFavoriteEvent({required this.cryptoId});

  @override
  List<Object?> get props => [cryptoId];
}

class RefreshFavoritesEvent extends FavoritesEvent{
  const RefreshFavoritesEvent();
}
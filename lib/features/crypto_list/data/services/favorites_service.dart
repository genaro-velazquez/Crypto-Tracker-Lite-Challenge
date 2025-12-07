


import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorites';
  final SharedPreferences prefs;

  FavoritesService({required this.prefs});

  // Obtener lista de IDs favoritos
  List<String> getFavoriteIds() {
    return prefs.getStringList(_favoritesKey) ?? [];
  }

  // Agregar favorito
  Future<void> addFavorite(String cryptoId) async {
    final favorites = getFavoriteIds();
    if (!favorites.contains(cryptoId)) {
      favorites.add(cryptoId);
      await prefs.setStringList(_favoritesKey, favorites);
    }
  }

  // Eliminar favorito
  Future<void> removeFavorite(String cryptoId) async {
    final favorites = getFavoriteIds();
    favorites.remove(cryptoId);
    await prefs.setStringList(_favoritesKey, favorites);
  }

  // Verificar si es favorito
  bool isFavorite(String cryptoId) {
    return getFavoriteIds().contains(cryptoId);
  }

  // Limpiar todos los favoritos
  Future<void> clearAll() async {
    await prefs.remove(_favoritesKey);
  }
}

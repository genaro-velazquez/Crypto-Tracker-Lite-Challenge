
import 'package:crypto_tracker_lite/config/dependency_injection/service_locator.dart';
import 'package:crypto_tracker_lite/config/theme/app_colors.dart';
import 'package:crypto_tracker_lite/config/theme/text_styles.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/favorites/favorites_state.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/pages/crypto_detail_page.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/viewmodels/favorites_viewmodel.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/atoms/custom_text.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/organisms/crypto_card.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/organisms/loading_display.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/templates/list_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late FavoritesViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<FavoritesViewModel>();
    viewModel.loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      bloc: viewModel.bloc,
      builder: (context, state) {
        // Cargando
        if (state is FavoritesLoading) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Icon(Icons.star, color: AppColors.gold, size: 28),
                  const SizedBox(width: 8),
                  const Text('Favoritos'),
                ],
              ),
              centerTitle: false,
            ),
            body: const LoadingDisplay(),
          );
        }

        // Vacío
        if (state is FavoritesEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Icon(Icons.star, color: AppColors.gold, size: 28),
                  const SizedBox(width: 8),
                  const Text('Favoritos'),
                ],
              ),
              centerTitle: false,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_outline,
                    size: 64,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: 16),
                  CustomText(
                    'No tienes favoritos aún',
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        }

        // Error
        if (state is FavoritesError) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Icon(Icons.star, color: AppColors.gold, size: 28),
                  const SizedBox(width: 8),
                  const Text('Favoritos'),
                ],
              ),
              centerTitle: false,
            ),
            body: Center(
              child: CustomText(
                state.message,
                style: AppTextStyles.bodyMedium,
              ),
            ),
          );
        }

        // Cargado
        if (state is FavoritesLoaded) {
          final favorites = state.favorites;

          final listView = favorites.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star_outline,
                        size: 64,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(height: 16),
                      CustomText(
                        'No tienes favoritos aún',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final crypto = favorites[index];

                    return CryptoCard(
                      id: crypto.id,
                      imageUrl: crypto.image,
                      name: crypto.name,
                      symbol: crypto.symbol,
                      currentPrice: crypto.currentPrice,
                      changePercentage: crypto.priceChangePercentage24h,
                      isFavorite: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CryptoDetailPage(
                              cryptoId: crypto.id,
                            ),
                          ),
                        );
                      },
                      onFavoriteTap: () async {
                        viewModel.removeFavorite(crypto.id);
                      },
                    );
                  },
                );

          return ListTemplate(
            title: 'Favoritos',
            listView: listView,
            onRefresh: () async {
              viewModel.refreshFavorites();
              await Future.delayed(const Duration(seconds: 1));
            },
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(
                  Icons.star,
                  color: AppColors.gold,
                  size: 24,
                ),
              ),
            ],
          );
        }

        return const Scaffold(
          body: LoadingDisplay(),
        );
      },
    );
  }
}

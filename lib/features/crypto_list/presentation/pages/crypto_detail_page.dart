import 'package:crypto_tracker_lite/config/dependency_injection/service_locator.dart';
import 'package:crypto_tracker_lite/config/theme/app_colors.dart';
import 'package:crypto_tracker_lite/features/crypto_list/data/services/favorites_service.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/crypto_detail/crypto_detail_bloc.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/crypto_detail/crypto_detail_state.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/viewmodels/crypto_detail_viewmodel.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/molecules/description_section.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/organisms/chart_section.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/organisms/crypto_detail_header.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/organisms/error_display.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/organisms/loading_display.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/organisms/market_stats_section.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/templates/content_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CryptoDetailPage extends StatefulWidget {
  final String cryptoId;

  const CryptoDetailPage({super.key, required this.cryptoId});

  @override
  State<CryptoDetailPage> createState() => _CryptoDetailPageState();
}

class _CryptoDetailPageState extends State<CryptoDetailPage> {
  late CryptoDetailViewmodel viewModel;
  late FavoritesService favoritesService;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<CryptoDetailViewmodel>();
    favoritesService = getIt<FavoritesService>();
    viewModel.loadCryptoDetail(widget.cryptoId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptoDetailBloc, CryptoDetailState>(
      bloc: viewModel.bloc,
      builder: (context, state) {
        // Cargando
        if (state is CryptoDetailLoading) {
          return ContentTemplate(
            title: 'Detalles',
            body: const LoadingDisplay(),
          );
        }

        // Error
        if (state is CryptoDetailError) {
          return ContentTemplate(
            title: 'Detalles',
            body: ErrorDisplay(
              message: state.message,
              onRetry: () => viewModel.loadCryptoDetail(widget.cryptoId),
            ),
          );
        }

        // Cargado
        if (state is CryptoDetailLoaded) {
          final crypto = state.crypto;
          final chartData = state.chartData;

          return ContentTemplate(
            title: 'Detalles',
            actions: [
              StatefulBuilder(
                builder: (context, setStateLocal) {
                  return IconButton(
                    icon: Icon(
                      favoritesService.isFavorite(widget.cryptoId)
                          ? Icons.star
                          : Icons.star_outline,
                      color: favoritesService.isFavorite(widget.cryptoId)
                          ? AppColors.gold
                          : AppColors.textSecondary,
                    ),
                    onPressed: () async {
                      final isFav =
                          favoritesService.isFavorite(widget.cryptoId);
                      if (isFav) {
                        await favoritesService.removeFavorite(widget.cryptoId);
                      } else {
                        await favoritesService.addFavorite(widget.cryptoId);
                      }
                      if (mounted) {
                        setStateLocal(() {});
                        setState(() {});
                      }
                    },
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
            body: RefreshIndicator(
              onRefresh: () async {
                viewModel.refreshCryptoDetail(widget.cryptoId);
                await Future.delayed(const Duration(seconds: 1));
              },
              child: ListView(
                children: [
                  // Header
                  CryptoDetailHeader(crypto: crypto),
                  // Estadísticas
                  MarketStatsSection(crypto: crypto),
                  // Gráfico
                  if (chartData != null)
                    ChartSection(
                      chartData: chartData,
                      cryptoName: crypto.name,
                    )
                  else
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      child: const Text('Cargando gráfico...'),
                    ),
                  // Descripción (NUEVO)
                  DescriptionSection(description: crypto.description),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        }

        return const ContentTemplate(
          title: 'Detalles',
          body: LoadingDisplay(),
        );
      },
    );
  }
}


/*
class CryptoDetailPage extends StatefulWidget {
  final String cryptoId;

  const CryptoDetailPage({super.key, required this.cryptoId});

  @override
  State<CryptoDetailPage> createState() => _CryptoDetailPageState();
}

class _CryptoDetailPageState extends State<CryptoDetailPage> {
  late CryptoDetailViewmodel viewModel;
  late FavoritesService favoritesService; // ← AGREGA ESTO

  @override
  void initState() {
    super.initState();
    viewModel = getIt<CryptoDetailViewmodel>();
    favoritesService = getIt<FavoritesService>(); // ← AGREGA ESTO
    viewModel.loadCryptoDetail(widget.cryptoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          StatefulBuilder(
            builder: (context, setStateLocal) {
              return IconButton(
                icon: Icon(
                  favoritesService.isFavorite(widget.cryptoId)
                      ? Icons.star
                      : Icons.star_outline,
                  color: favoritesService.isFavorite(widget.cryptoId)
                      ? AppColors.gold
                      : AppColors.textSecondary,
                ),
                onPressed: () async {
                  final isFav = favoritesService.isFavorite(widget.cryptoId);
                  if (isFav) {
                    await favoritesService.removeFavorite(widget.cryptoId);
                  } else {
                    await favoritesService.addFavorite(widget.cryptoId);
                  }
                  if (mounted) {
                    setStateLocal(() {});
                    setState(() {});
                  }
                },
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocBuilder<CryptoDetailBloc, CryptoDetailState>(
        bloc: viewModel.bloc,
        builder: (context, state) {
          // Cargando
          if (state is CryptoDetailLoading) {
            return const LoadingDisplay();
          }

          // Error
          if (state is CryptoDetailError) {
            return ErrorDisplay(
              message: state.message,
              onRetry: () => viewModel.loadCryptoDetail(widget.cryptoId),
            );
          }

          // Cargado
          if (state is CryptoDetailLoaded) {
            final crypto = state.crypto;
            final chartData = state.chartData;

            return RefreshIndicator(
              onRefresh: () async {
                viewModel.refreshCryptoDetail(widget.cryptoId);
                await Future.delayed(const Duration(seconds: 1));
              },
              child: ListView(
                children: [
                  // Header
                  CryptoDetailHeader(crypto: crypto),
                  // Estadísticas
                  MarketStatsSection(crypto: crypto),
                  // Gráfico
                  if (chartData != null)
                    ChartSection(chartData: chartData, cryptoName: crypto.name)
                  else
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      child: const Text('Cargando gráfico...'),
                    ),
                ],
              ),
            );
          }

          return const Scaffold(body: LoadingDisplay());
        },
      ),
    );
  }
}
*/
import 'package:crypto_tracker_lite/config/dependency_injection/service_locator.dart';
import 'package:crypto_tracker_lite/features/crypto_list/data/services/favorites_service.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/crypto_list/crypto_list_bloc.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/crypto_list/crypto_list_state.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/pages/crypto_detail_page.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/viewmodels/crypto_list_viewmodel.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/organisms/app_drawer.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/organisms/crypto_card.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/organisms/error_display.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/organisms/loading_display.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/templates/list_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoListPage extends StatefulWidget {
  const CryptoListPage({super.key});

  @override
  State<CryptoListPage> createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  late CryptoListViewModel viewModel;
  late FavoritesService favoritesService;

  @override
  void initState() {
    super.initState();
    // Obtener ViewModel del Service Locator
    viewModel = getIt<CryptoListViewModel>();
    favoritesService = getIt<FavoritesService>();
    // Cargar criptos
    viewModel.loadCryptos();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptoListBloc, CryptoListState>(
      bloc: viewModel.bloc,
      builder: (context, state) {
        // Estado: Cargando
        if (state is CryptoListLoading) {
          return Scaffold(
            appBar: AppBar(title: const Text('CryptoTracker Lite')),
            drawer: const AppDrawer(),  
            body: const LoadingDisplay(),
          );
        }

        // Estado: Error de rate limit
        if (state is CryptoListRateLimitError) {
          return Scaffold(
            appBar: AppBar(title: const Text('CryptoTracker Lite')),
            drawer: const AppDrawer(),
            body: ErrorDisplay(
              message: state.message,
              isRateLimit: true,
              onRetry: () => viewModel.loadCryptos(),
            ),
          );
        }

        // Estado: Error general
        if (state is CryptoListError) {
          return Scaffold(
            appBar: AppBar(title: const Text('CryptoTracker Lite')),
            drawer: const AppDrawer(),  
            body: ErrorDisplay(
              message: state.message,
              onRetry: () => viewModel.loadCryptos(),
            ),
          );
        }

        // Estado: Cargado
        if (state is CryptoListLoaded) {
          final cryptos = state.cryptos;

          return ListTemplate(
            title: 'CryptoTracker Lite',
            drawer: AppDrawer(
              onFavoritesReturn: (){
                viewModel.loadCryptos();
              },
            ),
            listView: cryptos.isEmpty
                ? ErrorDisplay(
                    message: 'No hay criptomonedas disponibles',
                    onRetry: () => viewModel.loadCryptos(),
                  )
                : ListView.builder(
                    itemCount: cryptos.length + 1,
                    itemBuilder: (context, index) {
                      // Última posición: botón para cargar más
                      if (index == cryptos.length) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButton(
                            onPressed: () => viewModel.loadMoreCryptos(
                              state.currentPage + 1,
                            ),
                            child: const Text('Cargar más'),
                          ),
                        );
                      }

                      final crypto = cryptos[index];

                      return CryptoCard(
                        id: crypto.id,
                        imageUrl: crypto.image,
                        name: crypto.name,
                        symbol: crypto.symbol,
                        currentPrice: crypto.currentPrice,
                        changePercentage: crypto.priceChangePercentage24h,
                        isFavorite: crypto.isFavorite,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CryptoDetailPage(cryptoId: crypto.id),
                            ),
                          ).then((_){
                              // Recargar lista cuando regresa
                              viewModel.loadCryptos();
                          });
                        },
                        onFavoriteTap: () async {
                          await viewModel.toggleFavorite(
                            crypto.id,
                            !crypto.isFavorite,
                          );
                          // Actualizar UI
                          if (mounted) {
                            setState(() {});
                          }
                        },
                      );
                    },
                  ),
            onRefresh: () async {
              viewModel.refreshCryptos();
              await Future.delayed(const Duration(seconds: 1));
            },
          );
        }

        // Estado: Inicial (por defecto)
        return Scaffold(
          appBar: AppBar(title: const Text('CryptoTracker Lite')),
          drawer: const AppDrawer(),  
          body: const LoadingDisplay(),
        );
      },
    );
  }
}


/*
class CryptoListPage extends StatefulWidget {
  const CryptoListPage({super.key});

  @override
  State<CryptoListPage> createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  late CryptoListViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = CryptoListViewModel();
    _loadData();
  }

  Future<void> _loadData() async {
    await viewModel.loadCryptos();
    if (mounted) {
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    // Si está cargando
    if (viewModel.isLoading) {
      return const LoadingDisplay();
    }

    // Si hay error
    if (viewModel.errorMessage != null) {
      return Scaffold(
        body: ErrorDisplay(
          message: viewModel.errorMessage!,
          onRetry: () {
            setState(() {
              viewModel.loadCryptos();
            });
          },
        ),
      );
    }

    // Construir lista
    final listView = viewModel.cryptos.isEmpty
        ? ErrorDisplay(
            message: 'No hay criptomonedas disponibles',
            onRetry: () {
              setState(() {
                viewModel.loadCryptos();
              });
            },
          )
        : ListView.builder(
            itemCount: viewModel.cryptos.length,
            itemBuilder: (context, index) {
              final crypto = viewModel.cryptos[index];

              return CryptoCard(
                id: crypto.id,
                imageUrl: crypto.image,
                name: crypto.name,
                symbol: crypto.symbol,
                currentPrice: crypto.currentPrice,
                changePercentage: crypto.priceChangePercentage24h,
                isFavorite: crypto.isFavorite,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Seleccionaste: ${crypto.name}')),
                  );
                },
                onFavoriteTap: () {
                  setState(() {
                    viewModel.toggleFavorite(crypto);
                  });
                },
              );
            },
          );

    // Usar Template
    return ListTemplate(
      title: 'CryptoTracker Lite',
      listView: listView,
      onRefresh: () async {
          await viewModel.refreshCryptos();
          if (mounted) {
            setState(() {});
          }
      },
    );
  }
}
*/
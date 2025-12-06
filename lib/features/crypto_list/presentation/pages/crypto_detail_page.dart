import 'package:crypto_tracker_lite/config/dependency_injection/service_locator.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/crypto_detail/crypto_detail_bloc.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/crypto_detail/crypto_detail_state.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/viewmodels/crypto_detail_viewmodel.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/organisms/chart_section.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/organisms/crypto_detail_header.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/organisms/error_display.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/organisms/loading_display.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/widgets/organisms/market_stats_section.dart';
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

  @override
  void initState() {
    super.initState();
    viewModel = getIt<CryptoDetailViewmodel>();
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
                  CryptoDetailHeader(
                    crypto: crypto,
                    onFavoriteTap: () {
                      // Implementar favoritos más adelante
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Funcionalidad de favoritos próximamente',
                          ),
                        ),
                      );
                    },
                  ),
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

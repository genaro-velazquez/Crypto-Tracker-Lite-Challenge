import 'package:crypto_tracker_lite/features/crypto_list/data/datasources/crypto_remote_datasource.dart';
import 'package:crypto_tracker_lite/features/crypto_list/data/repositories/crypto_repository_impl.dart';
import 'package:crypto_tracker_lite/features/crypto_list/data/services/favorites_service.dart';
import 'package:crypto_tracker_lite/features/crypto_list/domain/repositories/crypto_repository.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/crypto_detail/crypto_detail_bloc.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/crypto_list/crypto_list_bloc.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/favorites/favorites_bloc.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/viewmodels/crypto_detail_viewmodel.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/viewmodels/crypto_list_viewmodel.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/viewmodels/favorites_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // 1. SharedPreferences (Primero)
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // 2. Favorites Service
  getIt.registerSingleton<FavoritesService>(
    FavoritesService(prefs: getIt<SharedPreferences>()),
  );

  // 3. HTTP Client
  getIt.registerSingleton<http.Client>(http.Client());

  // 4. DataSource
  getIt.registerSingleton<CryptoRemoteDataSource>(
    CryptoRemoteDataSourceImpl(client: getIt<http.Client>()),
  );

  // 5. Repository (Usa FavoritesService)
  getIt.registerSingleton<CryptoRepository>(
    CryptoRepositoryImpl(
      remoteDataSource: getIt<CryptoRemoteDataSource>(),
      favoritesService: getIt<FavoritesService>(),
    ),
  );

  // 6. BLoCs
  getIt.registerSingleton<CryptoListBloc>(
    CryptoListBloc(repository: getIt<CryptoRepository>()),
  );

  getIt.registerFactory<CryptoDetailBloc>(
    () => CryptoDetailBloc(repository: getIt<CryptoRepository>()),
  );

  getIt.registerFactory<FavoritesBloc>(
    () => FavoritesBloc(
      repository: getIt<CryptoRepository>(),
      favoritesService: getIt<FavoritesService>(),
    ),
  );

  // 7. ViewModels
  getIt.registerSingleton<CryptoListViewModel>(
    CryptoListViewModel(
      bloc: getIt<CryptoListBloc>(),
      repository: getIt<CryptoRepository>(),
    ),
  );

  getIt.registerFactory<CryptoDetailViewmodel>(
    () => CryptoDetailViewmodel(bloc: getIt<CryptoDetailBloc>()),
  );

  getIt.registerFactory<FavoritesViewModel>(
    () => FavoritesViewModel(bloc: getIt<FavoritesBloc>()),
  );
}




import 'package:crypto_tracker_lite/features/crypto_list/data/datasources/crypto_remote_datasource.dart';
import 'package:crypto_tracker_lite/features/crypto_list/data/repositories/crypto_repository_impl.dart';
import 'package:crypto_tracker_lite/features/crypto_list/domain/repositories/crypto_repository.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/crypto_list/crypto_list_bloc.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/viewmodels/crypto_list_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

void setupServiceLocator() {
  // HTTP Client (Singleton)
  getIt.registerSingleton<http.Client>(
    http.Client(),
  );

  // DataSource (Singleton)
  getIt.registerSingleton<CryptoRemoteDataSource>(
    CryptoRemoteDataSourceImpl(client: getIt<http.Client>()),
  );

  // Repository (Singleton)
  getIt.registerSingleton<CryptoRepository>(
    CryptoRepositoryImpl(remoteDataSource: getIt<CryptoRemoteDataSource>()),
  );

  // BLoC (Singleton)
  getIt.registerSingleton<CryptoListBloc>(
    CryptoListBloc(repository: getIt<CryptoRepository>()),
  );

    // ViewModel (Singleton)
  getIt.registerSingleton<CryptoListViewModel>(
    CryptoListViewModel(bloc: getIt<CryptoListBloc>()),
  );

}

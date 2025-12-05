import 'package:crypto_tracker_lite/config/dependency_injection/service_locator.dart';
import 'package:crypto_tracker_lite/config/theme/app_theme.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/bloc/crypto_list/crypto_list_bloc.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/pages/crypto_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoTracker Lite',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      //home: const HomePage(),
      home: BlocProvider<CryptoListBloc>(
        create: (context) => getIt<CryptoListBloc>(),
        child: const CryptoListPage(),),
    );
  }
}

class HomePage extends StatelessWidget{
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
        return MaterialApp(
      title: 'CryptoTracker Lite',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const CryptoListPage(), 
    );
 
  }
}


import 'package:crypto_tracker_lite/config/dependency_injection/service_locator.dart';
import 'package:crypto_tracker_lite/features/crypto_list/presentation/pages/crypto_list_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoTracker Lite',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: const CryptoListPage(),
    );
  }
}

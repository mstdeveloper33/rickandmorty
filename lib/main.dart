import 'package:flutter/material.dart';
import 'package:rickyandmorty/app/locator.dart';
import 'package:rickyandmorty/app/router.dart';
import 'package:rickyandmorty/app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator(); //! Bu fonksiyon ile dependency injection işlemleri gerçekleştirilir.
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lighttheme,
      title: 'Material App',
     
    );
  }
}
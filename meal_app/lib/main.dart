import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/cubit/crypto_prices_cubit.dart';
import 'package:meal_app/router/routes.dart';
import 'package:meal_app/screens/coin_detail_screen.dart';
import 'package:meal_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CryptoPricesCubit()..getCryptoPrices(),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        routerConfig: _appRouter.config(),
      ),
    );
  }
}

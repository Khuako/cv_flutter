import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/cubit/crypto_prices_cubit.dart';
import 'package:meal_app/model/crypto_prices.dart';
import 'package:meal_app/router/routes.dart';
import 'package:meal_app/screens/coin_detail_screen.dart';
import 'package:meal_app/widgets/value_widget.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> images = [
    'images/aid.jpg',
    'images/bnb.png',
    'images/btc.png',
    'images/eth.png',
    'images/ltc.png',
    'images/trx.png',
  ];
  List<String> names = [
    'AID',
    'BNB',
    'BTC',
    'ETH',
    'LTC',
    'TRX',
  ];
  @override
  void initState() {
    context.read<CryptoPricesCubit>().getCryptoPrices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CryptoCurrencies Prices',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.qr_code_scanner_sharp,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CryptoPricesCubit>().getCryptoPrices();
        },
        child: ListView.separated(
            itemBuilder: (context, index) {
              return BlocBuilder<CryptoPricesCubit, CryptoPricesState>(
                builder: (context, state) {
                  if (state is CryptoPricesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CryptoPricesLoaded) {
                    List<Data> coinsList = state.cryptoPrices.data!;
                    return ValueWidget(
                        marketCap: coinsList[index].marketCapUsd!,
                        valueName: coinsList[index].name!,
                        valueDollar: coinsList[index].priceUsd!,
                        valueImage: images[index],
                        explorerLink: coinsList[index].explorer ?? "123.com");
                  }
                  return Text('Please reload again');
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(
                  thickness: 0.8,
                ),
            itemCount: images.length),
      ),
    );
  }
}

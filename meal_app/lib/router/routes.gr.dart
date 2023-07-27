// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'routes.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    CoinDetailRoute.name: (routeData) {
      final args = routeData.argsAs<CoinDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CoinDetailScreen(
          coinImage: args.coinImage,
          coinName: args.coinName,
          marketCap: args.marketCap,
          priceUsd: args.priceUsd,
        ),
      );
    },
  };
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CoinDetailScreen]
class CoinDetailRoute extends PageRouteInfo<CoinDetailRouteArgs> {
  CoinDetailRoute({
    required String coinImage,
    required String coinName,
    required String marketCap,
    required String priceUsd,
    List<PageRouteInfo>? children,
  }) : super(
          CoinDetailRoute.name,
          args: CoinDetailRouteArgs(
            coinImage: coinImage,
            coinName: coinName,
            marketCap: marketCap,
            priceUsd: priceUsd,
          ),
          initialChildren: children,
        );

  static const String name = 'CoinDetailRoute';

  static const PageInfo<CoinDetailRouteArgs> page =
      PageInfo<CoinDetailRouteArgs>(name);
}

class CoinDetailRouteArgs {
  const CoinDetailRouteArgs({
    required this.coinImage,
    required this.coinName,
    required this.marketCap,
    required this.priceUsd,
  });

  final String coinImage;

  final String coinName;

  final String marketCap;

  final String priceUsd;

  @override
  String toString() {
    return 'CoinDetailRouteArgs{coinImage: $coinImage, coinName: $coinName, marketCap: $marketCap, priceUsd: $priceUsd}';
  }
}

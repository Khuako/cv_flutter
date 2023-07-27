import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:meal_app/screens/home_screen.dart';

import '../screens/coin_detail_screen.dart';

part 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, path: '/'),
        AutoRoute(page: CoinDetailRoute.page),
      ];
}

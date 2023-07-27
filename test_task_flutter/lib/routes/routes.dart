import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:test_task_flutter/model/news_model.dart';

import '../ui/screens/main_screen.dart';
import '../ui/screens/news_detail_screen.dart';

part 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MainRoute.page, path: '/'),
        AutoRoute(page: NewsDetailRoute.page),
      ];
}

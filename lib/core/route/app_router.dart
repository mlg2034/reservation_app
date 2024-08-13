import 'package:auto_route/auto_route.dart';
import 'package:paloma_test_app/core/route/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: NavigationRoute.page,
          children: [
            CustomRoute(
              page: TablesRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              initial: true,
            ),
            
            CustomRoute(
              page: OrderHistoryRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
            )
          ],
          initial: true
        ),
        CustomRoute(
              transitionsBuilder: TransitionsBuilders.fadeIn,
              page: TableDetailtRoute.page,
            ),
      ];
}

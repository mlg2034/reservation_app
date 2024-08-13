import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paloma_test_app/core/route/app_router.gr.dart';
import 'package:paloma_test_app/src/ui_kit/ui_kit.dart';

@RoutePage()
class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>
    with TickerProviderStateMixin {
  TabController? tabController;
  int? index;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        TablesRoute(),
        OrderHistoryRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: tabsRouter.activeIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (value) {
            if (tabsRouter.activeIndex == value) {
              tabsRouter.canPop();
            } else {
              tabsRouter.setActiveIndex(value);
            }
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Tables',
              activeIcon: Icon(
                Icons.table_bar_outlined,
                color: AppColors.green,
              ),
              icon: Icon(
                Icons.table_bar_outlined,
                color: AppColors.blue,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                color: AppColors.blue,
              ),
              label: 'Orders',
              activeIcon: Icon(
                Icons.history,
                color: AppColors.green,
              ),
            ),
          ],
        );
      },
    );
  }
}

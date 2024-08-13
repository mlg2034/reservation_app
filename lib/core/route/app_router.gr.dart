// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:paloma_test_app/src/feature/main/screen/navigation_screen.dart'
    as _i1;
import 'package:paloma_test_app/src/feature/order/screen/order_history_screen.dart'
    as _i2;
import 'package:paloma_test_app/src/feature/table/screen/table_detailt_screen.dart'
    as _i3;
import 'package:paloma_test_app/src/feature/table/screen/tables_screen.dart'
    as _i4;

/// generated route for
/// [_i1.NavigationPage]
class NavigationRoute extends _i5.PageRouteInfo<void> {
  const NavigationRoute({List<_i5.PageRouteInfo>? children})
      : super(
          NavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'NavigationRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.NavigationPage();
    },
  );
}

/// generated route for
/// [_i2.OrderHistoryScreen]
class OrderHistoryRoute extends _i5.PageRouteInfo<void> {
  const OrderHistoryRoute({List<_i5.PageRouteInfo>? children})
      : super(
          OrderHistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderHistoryRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.OrderHistoryScreen();
    },
  );
}

/// generated route for
/// [_i3.TableDetailtScreen]
class TableDetailtRoute extends _i5.PageRouteInfo<TableDetailtRouteArgs> {
  TableDetailtRoute({
    _i6.Key? key,
    required int tableNumber,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          TableDetailtRoute.name,
          args: TableDetailtRouteArgs(
            key: key,
            tableNumber: tableNumber,
          ),
          rawPathParams: {'tableNumber': tableNumber},
          initialChildren: children,
        );

  static const String name = 'TableDetailtRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TableDetailtRouteArgs>(
          orElse: () => TableDetailtRouteArgs(
              tableNumber: pathParams.getInt('tableNumber')));
      return _i3.TableDetailtScreen(
        key: args.key,
        tableNumber: args.tableNumber,
      );
    },
  );
}

class TableDetailtRouteArgs {
  const TableDetailtRouteArgs({
    this.key,
    required this.tableNumber,
  });

  final _i6.Key? key;

  final int tableNumber;

  @override
  String toString() {
    return 'TableDetailtRouteArgs{key: $key, tableNumber: $tableNumber}';
  }
}

/// generated route for
/// [_i4.TablesScreen]
class TablesRoute extends _i5.PageRouteInfo<void> {
  const TablesRoute({List<_i5.PageRouteInfo>? children})
      : super(
          TablesRoute.name,
          initialChildren: children,
        );

  static const String name = 'TablesRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.TablesScreen();
    },
  );
}

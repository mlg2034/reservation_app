import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paloma_test_app/core/service_locator/service_locator.dart';
import 'package:paloma_test_app/src/feature/order/bloc/create_order/create_order_bloc.dart';
import 'package:paloma_test_app/src/feature/order/bloc/get_order_list/order_list_bloc.dart';
import 'package:paloma_test_app/src/feature/product/bloc/product_list_bloc_bloc.dart';
import 'package:paloma_test_app/src/feature/table/bloc/table_detail_bloc/table_detail_bloc.dart';
import 'package:paloma_test_app/src/feature/table/bloc/table_list_bloc/table_list_bloc.dart';

class MultiBlocWrapper extends StatelessWidget {
  final Widget child;
  const MultiBlocWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TableListBloc(sl()),
        ),
        BlocProvider(
          create: (context) => TableDetailBloc(sl()),
        ),
         BlocProvider(
          create: (context) => ProductListBloc(sl()),
        ),
        BlocProvider(
          create: (context) => OrderListBloc(sl()),
        ),
          BlocProvider(
          create: (context) => CreateOrderBloc(sl()),
        ),
      ],
      child: Builder(builder: (_) {
        return child;
      }),
    );
  }
}

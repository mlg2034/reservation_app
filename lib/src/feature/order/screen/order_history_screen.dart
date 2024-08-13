import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paloma_test_app/src/feature/order/view/order_pay_view.dart';
import 'package:paloma_test_app/src/ui_kit/ui_kit.dart';

@RoutePage()
class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        titleText: 'Order list',
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: OrderPayView(),
      ),
    );
  }
}

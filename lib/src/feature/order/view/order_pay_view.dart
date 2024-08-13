import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:paloma_test_app/src/feature/order/bloc/get_order_list/order_list_bloc.dart';
import 'package:paloma_test_app/src/feature/order/model/order_model.dart';
import 'package:paloma_test_app/src/ui_kit/ui_kit.dart';

class OrderPayView extends StatefulWidget {
  const OrderPayView({
    super.key,
  });

  @override
  State<OrderPayView> createState() => _OrderPayViewState();
}

class _OrderPayViewState extends State<OrderPayView> {
  _getOrder() {
    context.read<OrderListBloc>().add(GetOrderList());
  }

  @override
  void initState() {
    _getOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderListBloc, OrderListState>(
      builder: (context, state) {
        return switch (state) {
          OrderListInitial() ||
          OrderListLoading() =>
            const Center(child: CircularProgressIndicator.adaptive()),
          OrderListError(error: String error) => Column(
              children: [
                Text(error),
                ElevatedButton(
                  onPressed: () => _getOrder(),
                  child: const Text('Try Again'),
                )
              ],
            ),
          OrderListSuccess(orderList: List<OrderModel> orderList) =>
            orderList.isNotEmpty
                ? ListView.builder(
                    itemCount: orderList.length,
                    itemBuilder: (context, index) {
                      final order = orderList[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( 
                            order.guestName,
                            style: AppFonts.displayMedium
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'total cost \$ ${order.totalAmount.toString()}',
                            style: AppFonts.displayMedium
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Divider(
                            color: AppColors.grey,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: order.products?.length ?? 0,
                            itemBuilder: (context, index) {
                              final product = order.products?[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                          const Text('Products cost:'),

                                    Text(
                                      '${index + 1}* ${product?.name}',
                                      style: AppFonts.displayMedium,
                                    ),
                                    const SizedBox(height: 16),
                                    SquareButton(
                                      size: 8,
                                      borderColor: AppColors.green,
                                      child: Text(
                                        '\$  ${product?.cost.toString()}',
                                        style: AppFonts.displaySmall
                                            .copyWith(color: AppColors.green),
                                      ),
                                    ),
                                    const Divider(
                                      color: AppColors.grey,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    })
                : const Center(
                    child: Text('Orders are empty'),
                  )
        };
      },
    );
  }
}

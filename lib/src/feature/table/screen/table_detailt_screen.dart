import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paloma_test_app/src/feature/order/bloc/create_order/create_order_bloc.dart';
import 'package:paloma_test_app/src/feature/order/params/create_order_params.dart';
import 'package:paloma_test_app/src/feature/product/model/product_model.dart';
import 'package:paloma_test_app/src/feature/table/bloc/table_detail_bloc/table_detail_bloc.dart';
import 'package:paloma_test_app/src/feature/table/model/table_model.dart';
import 'package:paloma_test_app/src/feature/table/view/selected_order_item_view.dart';
import 'package:paloma_test_app/src/feature/table/view/table_menu_view.dart';
import 'package:paloma_test_app/src/ui_kit/ui_kit.dart';

@RoutePage()
class TableDetailtScreen extends StatefulWidget {
  final int tableNumber;
  const TableDetailtScreen({
    super.key,
    @PathParam('tableNumber') required this.tableNumber,
  });

  @override
  State<TableDetailtScreen> createState() => _TableDetailtScreenState();
}

class _TableDetailtScreenState extends State<TableDetailtScreen> {
  late ValueNotifier<List<ProductModel>> _selectedProductController;
  late ValueNotifier<double> _totalCost;
  final Map<ProductModel, ValueNotifier<int>> productCounts = {};

  @override
  void initState() {
    context.read<TableDetailBloc>().add(
          GetTableDetail(id: widget.tableNumber),
        );
    _totalCost = ValueNotifier(0.0);
    _selectedProductController = ValueNotifier([]);
    super.initState();
  }

  _createOrder(TableModel table) => () {
        context.read<CreateOrderBloc>().add(
              CreateOrder(
                params: CreateOrderParams(
                  guestName: table.waiter ?? '',
                  tableNumber: table.tableNumber,
                  finishedAt: DateTime.now(),
                  totalAmount: _totalCost.value,
                  questCount: table.seatsOccupied,
                  products: _selectedProductController.value,
                ),
              ),
            );
      };

  _calculateTotalCost() => () {
        double total = 0.0;
        for (var product in _selectedProductController.value) {
          total += product.cost * (productCounts[product]?.value ?? 0);
        }
        _totalCost.value = total;
      };

  _createOrderListener(BuildContext conxtext, CreateOrderState state) {
    if (state is CreateOrderSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order created'),
        ),
      );
      conxtext.router.maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        titleWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('T ${widget.tableNumber}'),
            const SizedBox(width: 12),
            ValueListenableBuilder(
                valueListenable: _totalCost,
                builder: (context, totalCost, child) {
                  return Text(
                    '\$ $totalCost',
                    style:
                        AppFonts.displayLarge.copyWith(color: AppColors.blue),
                  );
                })
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<TableDetailBloc, TableDetailState>(
          builder: (context, state) {
            return switch (state) {
              TableDetailInitial() || TableDetailLoading() => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              TableDetailError(error: String error) => Center(
                  child: Text(error),
                ),
              TableDetailSuccess(table: TableModel table) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectedOrderItemView(
                      productCounts: productCounts,
                      selectedProduct: _selectedProductController,
                      totalCost: _totalCost,
                      calculateProduct: _calculateTotalCost(),
                    ),
                    const Divider(
                      height: 1,
                      color: AppColors.grey,
                    ),
                    TableMenuView(
                      selectedProduct: _selectedProductController,
                      productCounts: productCounts,
                      calculateTotalCost: _calculateTotalCost(),
                    ),
                    const SizedBox(height: 24),
                    BlocConsumer<CreateOrderBloc, CreateOrderState>(
                      listener: _createOrderListener,
                      builder: (context, state) {
                        return switch (state) {
                          CreateOrderInitial() ||
                          CreateOrderSuccess() =>
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _createOrder(table),
                                child: const Text('Create Order'),
                              ),
                            ),
                          CreateOrderError(error: String error) => Center(
                              child: Text(error),
                            ),
                          CreateOrderLoading() => const Center(
                              child: CircularProgressIndicator.adaptive())
                        };
                      },
                    )
                  ],
                ),
            };
          },
        ),
      ),
    );
  }
}

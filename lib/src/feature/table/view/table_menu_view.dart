import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:paloma_test_app/src/feature/product/bloc/product_list_bloc_bloc.dart';
import 'package:paloma_test_app/src/feature/product/model/product_model.dart';
import 'package:paloma_test_app/src/ui_kit/ui_kit.dart';

class TableMenuView extends StatefulWidget {
  final ValueNotifier<List<ProductModel>> selectedProduct;
  final Map<ProductModel, ValueNotifier<int>> productCounts;
  final VoidCallback calculateTotalCost;
  const TableMenuView({
    super.key,
    required this.selectedProduct,
    required this.productCounts,
    required this.calculateTotalCost,
  });

  @override
  State<TableMenuView> createState() => _TableMenuViewState();
}

class _TableMenuViewState extends State<TableMenuView> {
  @override
  void initState() {
    context.read<ProductListBloc>().add(
          GetProductList(),
        );
    super.initState();
  }

  _addProductToOrder(ProductModel product) => () {
        final currentList =
            List<ProductModel>.from(widget.selectedProduct.value);
        currentList.add(product);
        widget.selectedProduct.value = currentList;
       widget.productCounts[product] ??= ValueNotifier<int>(1);
  widget.calculateTotalCost();
      };

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Menu',
              style: AppFonts.displayMedium,
            ),
          ),
          BlocBuilder<ProductListBloc, ProductListState>(
            builder: (context, state) {
              return switch (state) {
                ProductListInitial() ||
                ProductListLoading() =>
                  const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  ),
                ProductListError(error: String error) => SliverToBoxAdapter(
                    child: Center(child: Text(error)),
                  ),
                ProductListSuccess(
                  productList: List<ProductModel> productList
                ) =>
                  productList.isNotEmpty
                      ? SliverGrid.builder(
                          itemCount: productList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 4,
                            childAspectRatio: 2.5,
                          ),
                          itemBuilder: (context, index) {
                            final product = productList[index];
                            return GestureDetector(
                              onTap: _addProductToOrder(product),
                              child: CardWidget(
                                isVertical: false,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.name,
                                    style: AppFonts.displayMedium,
                                  ),
                                  Text(
                                    '\$ ${product.cost.toString()}',
                                    style: AppFonts.displayMedium
                                        .copyWith(color: AppColors.blue),
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      : const SliverToBoxAdapter(
                          child: Center(
                            child: Text('Product are not available'),
                          ),
                        ),
              };
            },
          ),
        ],
      ),
    );
  }
}

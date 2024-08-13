import 'package:flutter/material.dart';
import 'package:paloma_test_app/src/feature/product/model/product_model.dart';
import 'package:paloma_test_app/src/ui_kit/ui_kit.dart';

class SelectedOrderItemView extends StatefulWidget {
  final ValueNotifier<List<ProductModel>> selectedProduct;
  final ValueNotifier<double> totalCost;
  final Map<ProductModel, ValueNotifier<int>> productCounts;
  final VoidCallback calculateProduct;
  const SelectedOrderItemView({
    super.key,
    required this.selectedProduct,
    required this.totalCost,
    required this.productCounts,
    required this.calculateProduct
  });

  @override
  State<SelectedOrderItemView> createState() => _SelectedOrderItemViewState();
}

class _SelectedOrderItemViewState extends State<SelectedOrderItemView> {

  @override
  void initState() {
    super.initState();
    for (var product in widget.selectedProduct.value) {
     widget. productCounts[product] ??= ValueNotifier<int>(1);
    }
  }

  _incrementProduct(ProductModel product) => () {
        if (widget.productCounts[product] != null) {
          widget.productCounts[product]!.value++;
          widget.calculateProduct();
        }
      };

  _decrementProduct(ProductModel product) => () {
        if (widget.productCounts[product] != null &&
            widget.productCounts[product]!.value > 1) {
          widget.productCounts[product]!.value--;
                 widget.calculateProduct();

        }
      };

  _removeProduct(ProductModel product) => () {
        widget.selectedProduct.value =
            List<ProductModel>.from(widget.selectedProduct.value)
              ..remove(product);
        widget.productCounts.remove(product);
                widget.calculateProduct();

      };

 
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<ProductModel>>(
        valueListenable: widget.selectedProduct,
        builder: (context, prdouct, child) {
          return prdouct.isNotEmpty
              ? ListView.builder(
                  itemCount: prdouct.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final selectedProduct = prdouct[index];
                    return SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.07,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const VerticalDivider(
                              width: 8,
                              thickness: 4,
                              color: AppColors.blue,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${index + 1}*',
                              style: AppFonts.displaySmall
                                  .copyWith(color: AppColors.blue),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              selectedProduct.name,
                              style: AppFonts.displaySmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            SquareButton(
                              onTap: _incrementProduct(selectedProduct),
                              child: const Icon(Icons.add),
                            ),
                            const SizedBox(width: 4),
                            ValueListenableBuilder<int>(
                              valueListenable: widget.productCounts[selectedProduct]!,
                              builder: (context, count, child) {
                                return Text(count.toString());
                              },
                            ),
                            const SizedBox(width: 4),
                            SquareButton(
                              onTap: _decrementProduct(selectedProduct),
                              child: const Icon(Icons.remove),
                            ),
                            const Spacer(),
                            SquareButton(
                              borderColor: AppColors.red,
                              onTap: _removeProduct(selectedProduct),
                              child: const Icon(Icons.delete),
                            ),
                            const Spacer(),
                            ValueListenableBuilder(
                                valueListenable: widget.productCounts[selectedProduct]!,
                                builder: (context, value, child) {
                                  return Text(
                                    '\$ ${selectedProduct.cost * value}',
                                    overflow: TextOverflow.fade,
                                    style: AppFonts.displaySmall.copyWith(
                                      color: AppColors.blue,
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    );
                  })
              : const Center(
                  child: Text('Please , select products'),
                );
        });
  }
}

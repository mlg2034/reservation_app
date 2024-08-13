import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:paloma_test_app/core/route/app_router.gr.dart';
import 'package:paloma_test_app/src/feature/table/model/table_model.dart';
import 'package:paloma_test_app/src/ui_kit/ui_kit.dart';

class TableCardsView extends StatelessWidget {
  final List<TableModel> tableList;
  const TableCardsView({
    super.key,
    required this.tableList,
  });

  _toDetailScreen(BuildContext context, int tableNumber) => () {
        context.router.push(
          TableDetailtRoute(tableNumber: tableNumber),
        );
      };
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      primary: false,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid.builder(
            itemCount: tableList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 8,
              mainAxisSpacing: 12,
              crossAxisCount: (tableList.length < 3) ? tableList.length : 3,
            ),
            itemBuilder: (context, index) {
              final table = tableList[index];
              return GestureDetector(
                onTap: _toDetailScreen(context, table.id!),
                child: CardWidget(
                  padding: EdgeInsets.zero,
                  children: [
                    const Spacer(),
                    Text('T ${table.tableNumber}',
                        style: AppFonts.displayMedium),
                    const SizedBox(height: 12),
                    Text(
                      table.waiter ?? 'Without resident',
                      style: AppFonts.displaySmall,
                    ),
                    const Spacer(),
                    DecoratedBox(
                      decoration: const BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${table.seatsOccupied}/${table.maxSeats}',
                                style: AppFonts.paragraph),
                            Text(
                              DateTime.now().second.toString(),
                              style: AppFonts.paragraph,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

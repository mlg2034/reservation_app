import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paloma_test_app/src/feature/table/bloc/table_list_bloc/table_list_bloc.dart';
import 'package:paloma_test_app/src/feature/table/model/table_model.dart';
import 'package:paloma_test_app/src/feature/table/view/table_cards_view.dart';
import 'package:paloma_test_app/src/ui_kit/ui_kit.dart';

@RoutePage()
class TablesScreen extends StatefulWidget {
  const TablesScreen({super.key});

  @override
  State<TablesScreen> createState() => _TablesScreenState();
}

class _TablesScreenState extends State<TablesScreen> {
  _getTable() {
    context.read<TableListBloc>().add(GetTableList());
  }

  @override
  void initState() {
    _getTable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(titleText: 'Table Service'),
      body: BlocBuilder<TableListBloc, TableListState>(
        builder: (context, state) {
          return switch (state) {
            TableListInitial() || TableListLoading() => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            TableListError(error: String error) => Column(
                children: [
                  Text(error),
                  ElevatedButton(
                    onPressed: () => _getTable(),
                    child: const Text('Try Again'),
                  )
                ],
              ),
            TableListSuccess(tableList: List<TableModel> tableList) =>
              tableList.isNotEmpty
                  ? TableCardsView(tableList: tableList)
                  : const Center(
                      child: Text('Tables are empty'),
                    )
          };
        },
      ),
    );
  }
}

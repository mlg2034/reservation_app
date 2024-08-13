import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paloma_test_app/src/feature/table/data/table_repository.dart';
import 'package:paloma_test_app/src/feature/table/model/table_model.dart';

part 'table_list_events.dart';
part 'table_list_state.dart';

class TableListBloc extends Bloc<TableListEvent, TableListState> {
  final TableRepository _tableRepository;
  TableListBloc(this._tableRepository) : super(TableListInitial()) {
    on<GetTableList>(_getTableList);
  }

  Future<void> _getTableList(
      GetTableList event, Emitter<TableListState> emit) async {
    if (state is TableListLoading) return;
    emit(TableListLoading());
    try {
      final result = await _tableRepository.getAllTables();
      emit(
        TableListSuccess(tableList: result),
      );
    } catch (error) {
      emit(
        TableListError(error: error.toString()),
      );
    }
  }
}

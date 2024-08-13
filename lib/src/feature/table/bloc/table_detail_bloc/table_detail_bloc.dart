import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paloma_test_app/src/feature/table/data/table_repository.dart';
import 'package:paloma_test_app/src/feature/table/model/table_model.dart';

part 'table_detail_events.dart';
part 'table_detail_state.dart';

class TableDetailBloc extends Bloc<TableDetailEvent, TableDetailState> {
  final TableRepository _tableRepository;
  TableDetailBloc(this._tableRepository) : super(TableDetailInitial()) {
    on<GetTableDetail>(_getTableDetail);
  }

  Future<void> _getTableDetail(
      GetTableDetail event, Emitter<TableDetailState> emit) async {
    if (state is TableDetailLoading) return;
    emit(TableDetailLoading());
    try {
      final result = await _tableRepository.getTable(event.id);
      emit(TableDetailSuccess(table: result));
    } catch (error) {
      emit(
        TableDetailError(error: error.toString()),
      );
    }
  }
}
